--  MURMUR3
--
--  taken from http://commons.ada.cx/Deterministic_Hashing
--  source at http://pastebin.com/ZhgRacMr
--
--  Baldrick on #ada provided an implementation of Murmur3.
--  Generic_Murmur3 is the core logic, the rest are convenience functions.
--
--  license: asked on #ada (Baldrick, 2014-04-07): public domain

with Ada.Unchecked_Conversion;

package body Hashing is

   use Ada.Containers;
   use System.Storage_Elements;
   use System;

   --  The hashes are all implemented using the storage array hash.

   pragma Assert (Storage_Element'Size = 8);
   --  We assume that a Storage_Element is essentially the same as an octet.

   pragma Assert (Hash_Type'Size = 32);
   --  Currently we only support hashing to a 32 bit value.

   pragma Assert (Default_Bit_Order = Low_Order_First);
   --  Currently we only support little-endian machines.  The implementation may
   --  actually be OK for big-endian machines too, but this needs to be checked.

   function Rotate_Left (V : Hash_Type; N : Natural) return Hash_Type;
   pragma Import (Intrinsic, Rotate_Left);

   function Shift_Left (V : Hash_Type; N : Natural) return Hash_Type;
   pragma Import (Intrinsic, Shift_Left);

   function Shift_Right (V : Hash_Type; N : Natural) return Hash_Type;
   pragma Import (Intrinsic, Shift_Right);

   ---------------------
   -- Generic_Murmur3 --
   ---------------------

   generic
   function Generic_Murmur3 (S : Storage_Array; Seed : Hash_Type) return Hash_Type;
   pragma Inline (Generic_Murmur3);
   --  This is MurmurHash3_x86_32.  Making this generic is a trick that gives
   --  us a way of forcing the compiler to inline the code into any generics
   --  that use it.

   function Generic_Murmur3 (S : Storage_Array; Seed : Hash_Type) return Hash_Type is
      pragma Suppress (All_Checks);

      subtype Store4 is Storage_Array (1 .. 4);

      function FMix32 (H : Hash_Type) return Hash_Type;
      pragma Inline (FMix32);
      --  Finalization mix - force all bits of a hash block to avalanche.

      function FMix32 (H : Hash_Type) return Hash_Type is
         R : Hash_Type := H;
      begin
         R := R xor Shift_Right (R, 16);
         R := R * 16#85ebca6b#;
         R := R xor Shift_Right (R, 13);
         R := R * 16#c2b2ae35#;
         R := R xor Shift_Right (R, 16);

         return R;
      end FMix32;

      function Get_Block_32 is new Ada.Unchecked_Conversion
        (Store4,
         Hash_Type);

      C1 : constant Hash_Type := 16#cc9e2d51#;
      C2 : constant Hash_Type := 16#1b873593#;

      NBlocks : constant Storage_Count := S'Length / 4;

      H1 : Hash_Type := Seed;
   begin
      --  Body.

      for I in 0 .. NBlocks - 1 loop
         declare
            Offset : constant Storage_Count  := 4 * I;
            First  : constant Storage_Offset := S'First + Offset;
            Last   : constant Storage_Offset := First + 3;
            K1     : Hash_Type := Get_Block_32 (S (First .. Last));
         begin
            K1 := K1 * C1;
            K1 := Rotate_Left (K1, 15);
            K1 := K1 * C2;

            H1 := H1 xor K1;
            H1 := Rotate_Left (H1, 13);
            H1 := H1 * 5 + 16#e6546b64#;
         end;
      end loop;

      --  Tail.

      declare
         Offset : constant Storage_Count  := 4 * NBlocks;
         Left   : constant Storage_Count  := S'Length - Offset;
         Base   : constant Storage_Offset := S'First + Offset;
         K1     : Hash_Type := 0;
      begin
         if Left >= 3 then
            K1 := K1 xor Shift_Left (Storage_Element'Pos (S (Base + 2)), 16);
         end if;
         if Left >= 2 then
            K1 := K1 xor Shift_Left (Storage_Element'Pos (S (Base + 1)), 8);
         end if;
         if Left >= 1 then
            K1 := K1 xor Storage_Element'Pos (S (Base));
            K1 := K1 * C1;
            K1 := Rotate_Left (K1, 15);
            K1 := K1 * C2;
            H1 := H1 xor K1;
         end if;
      end;

      --  Finalization.

      H1 := H1 xor S'Length;

      H1 := FMix32 (H1);

      return H1;
   end Generic_Murmur3;

   -------------
   -- Murmur3 --
   -------------

   function Murmur3 is new Generic_Murmur3;

   ----------
   -- Hash --
   ----------

   function Hash
     (S    : Storage_Array;
      Seed : Hash_Type)
      return Hash_Type renames
     Murmur3;

   function Hash (A : Address; Seed : Hash_Type) return Hash_Type is
      subtype St is Storage_Array (1 .. Address'Object_Size / 8);
      function To_Storage is new Ada.Unchecked_Conversion (Address, St);
   begin
      return Hash (To_Storage (A), Seed);
   end Hash;


   ----------------------------
   -- Anonymous_Pointer_Hash --
   ----------------------------

   function Anonymous_Pointer_Hash (
     Pointer : access constant Any_Type;
     Seed    : Hash_Type
   ) return Hash_Type
   is
      Addr : Address;
   begin
      if Pointer = null then
         Addr := Null_Address;
      else
         Addr := Pointer.all'Address;
      end if;

      return Hash (Addr, Seed);
   end Anonymous_Pointer_Hash;

   ----------------------
   -- All_Pointer_Hash --
   ----------------------

   function All_Pointer_Hash (
     Pointer : Any_Access;
     Seed    : Hash_Type
   ) return Hash_Type is
      Addr : Address;
   begin
      if Pointer = null then
         Addr := Null_Address;
      else
         Addr := Pointer.all'Address;
      end if;

      return Hash (Addr, Seed);
   end All_Pointer_Hash;

   ---------------------------
   -- Constant_Pointer_Hash --
   ---------------------------

   function Constant_Pointer_Hash (
     Pointer : Any_Access;
     Seed    : Hash_Type
   ) return Hash_Type is
      Addr : Address;
   begin
      if Pointer = null then
         Addr := Null_Address;
      else
         Addr := Pointer.all'Address;
      end if;

      return Hash (Addr, Seed);
   end Constant_Pointer_Hash;

   -------------------
   -- Discrete_Hash --
   -------------------

   function Discrete_Hash (
     Value : T;
     Seed  : Hash_Type
   ) return Hash_Type is
      --  The problem here is that a T might not fill up a byte (or an integer
      --  number of bytes) - think of Boolean.  To solve this, we create a null-
      --  initialized storage area on the stack that is large enough to store a
      --  T to.  We then store Value to it, and hash the storage.

      subtype St_Type is Storage_Array (1 .. T'Object_Size / 8);
      St : aliased St_Type := (others => 0);
      --  The null-initialized storage.

      --  To store Value to St, we take a pointer to St, change it into a
      --  pointer to type T, and store Value through it.
      type St_Pointer is access all St_Type;
      for St_Pointer'Storage_Size use 0;
      type T_Pointer is access all T;
      for T_Pointer'Storage_Size use 0;
      function To_T is new Ada.Unchecked_Conversion (St_Pointer, T_Pointer);

      function M3 is new Generic_Murmur3;
   --  Instantiate our own copy of Murmur3 to make sure it gets inlined, as
   --  this leads to many simplifications due to the length of the storage
   --  being known.
   begin
      --  Store Value to the storage area.
      To_T (St'Access).all := Value;
      --  Hash the storage area.
      return M3 (St, Seed);
   end Discrete_Hash;

   ------------------
   -- Pointer_Hash --
   ------------------

   function Pointer_Hash (
     Pointer : Any_Access;
     Seed    : Hash_Type
   ) return Hash_Type is
      Addr : Address;
   begin
      if Pointer = null then
         Addr := Null_Address;
      else
         Addr := Pointer.all'Address;
      end if;

      return Hash (Addr, Seed);
   end Pointer_Hash;

end Hashing;

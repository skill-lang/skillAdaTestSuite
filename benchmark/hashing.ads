--  MURMUR3
--
--  taken from http://commons.ada.cx/Deterministic_Hashing
--  source at http://pastebin.com/ZhgRacMr
--
--  Baldrick on #ada provided an implementation of Murmur3.
--  Generic_Murmur3 is the core logic, the rest are convenience functions.
--
--  license: asked on #ada (Baldrick, 2014-04-07): public domain

with Ada.Containers;
with System.Storage_Elements;

package Hashing is

   pragma Pure;

   --  Provides a set of easy to use, efficient and well-behaved hash functions.
   --  These are not cryptographic (secure) hashes, they are designed for use in
   --  hash tables and such like. It is easy to add support for more types (just
   --  ask).

   --  Storage  --

   function Hash
     (S    : System.Storage_Elements.Storage_Array;
      Seed : Ada.Containers.Hash_Type)
      return Ada.Containers.Hash_Type with Inline;
   function Hash (S : System.Storage_Elements.Storage_Array)
     return Ada.Containers.Hash_Type is (Hash (S, 0));

   --  Discrete types (includes integers)  --

   generic
      type T is (<>);
   function Discrete_Hash (
     Value : T;
     Seed  : Ada.Containers.Hash_Type
   ) return Ada.Containers.Hash_Type with Inline;

   --  Pointer types  --

   function Hash
     (A    : System.Address;
      Seed : Ada.Containers.Hash_Type)
      return Ada.Containers.Hash_Type with Inline, Pure_Function;
   --  Yes, this is really pure in spite of using System.Address (GNAT disables
   --  pureness of functions using System.Address by default because users often
   --  turn the address into a pointer and do impure things with it).
   function Hash (A : System.Address) return Ada.Containers.Hash_Type
     is (Hash (A, 0));

   generic
      type Any_Type (<>) is limited private;
   function Anonymous_Pointer_Hash (
     Pointer : access constant Any_Type;
     Seed    : Ada.Containers.Hash_Type
   ) return Ada.Containers.Hash_Type with Inline;

   generic
      type Any_Type (<>) is limited private;
      type Any_Access is access all Any_Type;
   function All_Pointer_Hash (
     Pointer : Any_Access;
     Seed    : Ada.Containers.Hash_Type
   ) return Ada.Containers.Hash_Type with Inline;

   generic
      type Any_Type (<>) is limited private;
      type Any_Access is access constant Any_Type;
   function Constant_Pointer_Hash (
     Pointer : Any_Access;
     Seed    : Ada.Containers.Hash_Type
   ) return Ada.Containers.Hash_Type with Inline;

   generic
      type Any_Type (<>) is limited private;
      type Any_Access is access Any_Type;
   function Pointer_Hash (
     Pointer : Any_Access;
     Seed    : Ada.Containers.Hash_Type
   ) return Ada.Containers.Hash_Type with Inline;

end Hashing;

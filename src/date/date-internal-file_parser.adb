package body Date.Internal.File_Parser is

   package Byte_Reader renames Date.Internal.Byte_Reader;
   Type_Declarations : Type_Declarations_Hash_Map.Map;

   procedure Read (File_Name : String) is
      Input_File : ASS_IO.File_Type;
   begin
      ASS_IO.Open (Input_File, ASS_IO.In_File, File_Name);
      Byte_Reader.Initialize (ASS_IO.Stream (Input_File));

      while (not ASS_IO.End_Of_File (Input_File)) loop
         String_Pool.Put (Read_String_Block);
         Read_Type_Block;
      end loop;

      ASS_IO.Close (Input_File);
   end Read;

   function Read_String_Block return String_Pool_Type is
      Count : Long := Byte_Reader.Read_v64;
      String_Lengths : array (1 .. Count) of Integer;
      New_String_Pool : String_Pool_Type (1 .. Count);
      Last_End : Integer := 0;
   begin
      --  read ends and calculate lengths
      for I in String_Lengths'Range loop
         declare
            String_End : Integer := Byte_Reader.Read_i32;
            String_Length : Integer := String_End - Last_End;
         begin
            String_Lengths (I) := String_End - Last_End;
            Last_End := String_End;
         end;
      end loop;

      --  read strings
      for I in String_Lengths'Range loop
         declare
            String_Length : Integer := String_Lengths (I);
            Next_String : String := Byte_Reader.Read_String (String_Length);
         begin
            New_String_Pool (I) := SU.To_Unbounded_String (Next_String);
         end;
      end loop;

      return New_String_Pool;
   end Read_String_Block;

   procedure Read_Type_Block is
      count: Long := Byte_Reader.Read_v64;
   begin
      for I in 1 .. count loop
         Read_Type_Declaration;
      end loop;

      Read_Field_Data;
   end Read_Type_Block;

   procedure Read_Type_Declaration is
      name : SU.Unbounded_String := String_Pool.Get (Byte_Reader.Read_v64);
      Type_Declaration : Type_Declaration_Type;
      fields : Field_Declarations_Vector.Vector;
   begin
      --  ABFRAGE, OB WIR name SCHON KENNEN, ANSONSTEN:
      --  if (not Type_Declarations.Contains (name))
      declare
         super : Long := Byte_Reader.Read_v64;
         instancesCount : Long := Byte_Reader.Read_v64;
      begin
         Type_Declaration := (name, super, instancesCount, -1, fields); --  TODO !!!
         Type_Declarations.Insert (name, Type_Declaration);
      end;

      --  skip restrictions
      declare restrictions_unused : Long := Byte_Reader.Read_v64; begin null; end;

      --  read field declaration
      declare
         count : Long := Byte_Reader.Read_v64;
      begin
         for I in 1 .. count loop
            Read_Field_Declaration (Type_Declaration);
         end loop;
      end;
   end Read_Type_Declaration;

   procedure Read_Field_Declaration (Type_Declaration : Type_Declaration_Type) is
      Field_Declaration : Field_Declaration_Type;
   begin
      --  skip restrictions
      declare restrictions_unused : Long := Byte_Reader.Read_v64; begin null; end;

      declare
         ftype : Short_Short_Integer := Byte_Reader.Read_i8;
         name : SU.Unbounded_String := String_Pool.Get (Byte_Reader.Read_v64);
         offset : Long := Byte_Reader.Read_v64;
      begin
         Field_Declaration := (ftype, name, offset);
      end;
   end Read_Field_Declaration;

   procedure Read_Field_Data is
   begin
      for I in 1 .. 2 loop
         Ada.Text_IO.Put_Line (Long'Image (Byte_Reader.Read_v64));
      end loop;
   end Read_Field_Data;

   --  hash map functions
   function Equivalent_Keys (Left, Right : SU.Unbounded_String) return Boolean is
      use SU;
   begin
      return Left = Right;
   end Equivalent_Keys;

   function Hash (Key : SU.Unbounded_String) return Ada.Containers.Hash_Type is (Ada.Strings.Hash (SU.To_String (Key)));

end Date.Internal.File_Parser;

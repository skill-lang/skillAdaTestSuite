package body Date.Internal.File_Parser is

   package Byte_Reader renames Date.Internal.Byte_Reader;

   procedure Read (File_Name : String) is
      Input_File : ASS_IO.File_Type;
   begin
      ASS_IO.Open (Input_File, ASS_IO.In_File, File_Name);
      Byte_Reader.Initialize (ASS_IO.Stream (Input_File));

      Read_String_Block;
      Read_Type_Block;

      ASS_IO.Close (Input_File);
   end Read;

   procedure Read_String_Block is
      Length : Long := Byte_Reader.Read_v64;
      String_Lengths : array (1 .. Length) of Integer;
   begin
      for I in String_Lengths'Range loop
         String_Lengths (I) := Byte_Reader.Read_i32;
      end loop;

      for I in String_Lengths'Range loop
         declare
            New_String : String := Byte_Reader.Read_String (String_Lengths(I));
         begin
            Ada.Text_IO.Put_Line (New_String);
         end;
      end loop;
   end Read_String_Block;

   procedure Read_Type_Block is
   begin
      Ada.Text_IO.Put_Line (Long'Image (Byte_Reader.Read_v64));
      Ada.Text_IO.Put_Line (Long'Image (Byte_Reader.Read_v64));
      Ada.Text_IO.Put_Line (Long'Image (Byte_Reader.Read_v64));
      Ada.Text_IO.Put_Line (Long'Image (Byte_Reader.Read_v64));
      Ada.Text_IO.Put_Line (Long'Image (Byte_Reader.Read_v64));
      Ada.Text_IO.Put_Line (Long'Image (Byte_Reader.Read_v64));
      Ada.Text_IO.Put_Line (Long'Image (Byte_Reader.Read_v64));
      Ada.Text_IO.Put_Line (Long'Image (Byte_Reader.Read_v64));
      Ada.Text_IO.Put_Line (Long'Image (Byte_Reader.Read_v64));
      Ada.Text_IO.Put_Line (Long'Image (Byte_Reader.Read_v64));

      for I in 1 .. 2 loop
         Ada.Text_IO.Put_Line (Long'Image (Byte_Reader.Read_v64));
      end loop;
   end Read_Type_Block;

end Date.Internal.File_Parser;

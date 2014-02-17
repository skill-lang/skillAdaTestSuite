package body Date.Internal.File_Parser is

   package Byte_Reader renames Date.Internal.Byte_Reader;
   package String_Pool renames Date.Internal.String_Pool;

   procedure Read (File_Name : String) is
      Input_File : ASS_IO.File_Type;
   begin
      ASS_IO.Open (Input_File, ASS_IO.In_File, File_Name);
      Byte_Reader.Initialize (ASS_IO.Stream (Input_File));

      while (not ASS_IO.End_Of_File (Input_File)) loop
         String_Pool.Put (Read_String_Block);
         Read_Type_Block;
      end loop;

      for I in String_Pool.Get_All'Range loop
         Ada.Text_IO.Put_Line (Long'Image (I) & ": " & String_Pool.Get (I));
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

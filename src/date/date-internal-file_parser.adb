package body Date.Internal.File_Parser is

   package Byte_Reader renames Date.Internal.Byte_Reader;

   procedure Read (File_Name : String) is
      Input_File : ASS_IO.File_Type;
      String_Pool : String_Pool_Type_Access := new String_Pool_Type (1 .. 0);
   begin
      ASS_IO.Open (Input_File, ASS_IO.In_File, File_Name);
      Byte_Reader.Initialize (ASS_IO.Stream (Input_File));

      Update_String_Pool (String_Pool);
      Update_String_Pool (String_Pool);
      Update_String_Pool (String_Pool);
      Update_String_Pool (String_Pool);
      Update_String_Pool (String_Pool);
      Update_String_Pool (String_Pool);

      for I in String_Pool'Range loop
         Ada.Text_IO.Put_Line (Long'Image (I) & ": " & SU.To_String (String_Pool (I)));
      end loop;

--      Read_Type_Block;

      ASS_IO.Close (Input_File);
   end Read;

   function Read_String_Block return String_Pool_Type is
      Length : Long := Byte_Reader.Read_v64;
      String_Lengths : array (1 .. Length) of Integer;
      New_String_Pool : String_Pool_Type (1 .. Length);
   begin
      for I in String_Lengths'Range loop
         String_Lengths (I) := Byte_Reader.Read_i32;
      end loop;

      for I in String_Lengths'Range loop
         declare
            Next_String : String := Byte_Reader.Read_String (String_Lengths (I));
         begin
            New_String_Pool (I) := SU.To_Unbounded_String (Next_String);
         end;
      end loop;

      return New_String_Pool;
   end Read_String_Block;

   procedure Update_String_Pool (String_Pool : in out String_Pool_Type_Access) is
      procedure Free is new Ada.Unchecked_Deallocation (String_Pool_Type, String_Pool_Type_Access);

      New_String_Pool : String_Pool_Type := Read_String_Block;
      Old_String_Pool : String_Pool_Type (String_Pool'Range);
   begin
      --  copy current string pool
      for I in String_Pool'Range loop
         Old_String_Pool (I) := String_Pool (I);
      end loop;

      Free (String_Pool);
      String_Pool := new String_Pool_Type (1 .. Old_String_Pool'Length + New_String_Pool'Length);

      --  restore old string pool
      for I in Old_String_Pool'Range loop
         String_Pool (I) := Old_String_Pool (I);
      end loop;

      --  add new strings
      for I in New_String_Pool'Range loop
         String_Pool (Old_String_Pool'Length + I) := New_String_Pool (I);
      end loop;
   end Update_String_Pool;

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

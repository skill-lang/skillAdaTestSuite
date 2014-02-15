package body Date.Api.Skill_State is

   procedure Read (File_Name : String) is
      A : Date_Type := (Date => 5);
      B : Date_Type := (Date => -5);
      Dates : array (1 .. 2) of Date_Type;
   begin
      Date.Internal.File_Parser.Read (File_Name);

      Ada.Text_IO.New_Line;

      Dates (1) := A;
      Dates (2) := B;

      for I in Dates'Range loop
         Ada.Text_IO.Put_Line (Long'Image (Dates (I).Date));
      end loop;
   end Read;

   procedure Write (File_Name : String) is
      package Byte_Writer renames Date.Internal.Byte_Writer;
      Output_File : ASS_IO.File_Type;
   begin
      ASS_IO.Open (Output_File, ASS_IO.Out_File, File_Name);
      Ada.Text_IO.Put_Line (File_Name);

      Byte_Writer.Initialize (ASS_IO.Stream (Output_File));
      Byte_Writer.Write_v64 (-5);

      ASS_IO.Close (Output_File);
   end Write;

end Date.Api.Skill_State;

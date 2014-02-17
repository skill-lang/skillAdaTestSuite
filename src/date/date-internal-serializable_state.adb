package body Date.Internal.Serializable_State is

   package ASS_IO renames Ada.Streams.Stream_IO;
   package String_Pool renames Date.Internal.String_Pool;

   procedure Read (File_Name : String) is
   begin
      Date.Internal.File_Parser.Read (File_Name);
   end Read;

   procedure Write (File_Name : String) is
      package Byte_Writer renames Date.Internal.Byte_Writer;

      Output_File : ASS_IO.File_Type;
      Output_Stream : ASS_IO.Stream_Access;
   begin
      ASS_IO.Create (Output_File, ASS_IO.Out_File, File_Name);
      Output_Stream := ASS_IO.Stream (Output_File);

      Byte_Writer.Initialize (Output_Stream);

      Byte_Writer.Write_v64 (3);
      Byte_Writer.Write_i32 (6);
      Byte_Writer.Write_i32 (12);
      Byte_Writer.Write_i32 (16);
      Byte_Writer.Write_String ("Dennis");
      Byte_Writer.Write_String ("stefan");
      Byte_Writer.Write_String ("timm");

      Byte_Writer.Write_v64 (1);
      Byte_Writer.Write_i32 (12);
      Byte_Writer.Write_String ("ABC oder XYZ");

      Byte_Writer.Write_v64 (0);

      Byte_Writer.Write_v64 (1);
      Byte_Writer.Write_i32 (3);
      Byte_Writer.Write_String ("XYZ");

      Byte_Writer.Write_v64 (0);

      Byte_Writer.Write_v64 (2);
      Byte_Writer.Write_i32 (3);
      Byte_Writer.Write_i32 (9);
      Byte_Writer.Write_String ("asd");
      Byte_Writer.Write_String ("123 56");

      ASS_IO.Close (Output_File);
   end Write;

end Date.Internal.Serializable_State;

package body Date.Test.Byte_Checker_String is

   procedure Initialize (T : in out Test) is
   begin
      Set_Name (T, "Date.Test.Byte_Checker_String");
      Ahven.Framework.Add_Test_Routine (T, String_1'Access, "String 1");
   end Initialize;

   function Write_Read (Value : String) return String is
      Temp_File : ASS_IO.File_Type;
      Temp_Stream : ASS_IO.Stream_Access;
      rval : String (Value'Range);
   begin
      ASS_IO.Create (Temp_File, ASS_IO.Out_File);
      Temp_Stream := ASS_IO.Stream (Temp_File);

      Byte_Writer.Initialize (Temp_Stream);
      Byte_Writer.Write_String (Value);

      ASS_IO.Reset (Temp_File, ASS_IO.In_File);
      Byte_Reader.Initialize (Temp_Stream);
      rval := Byte_Reader.Read_String (Value'Length);

      ASS_IO.Close (Temp_File);

      return rval;
   end Write_Read;

   procedure String_1 is
      Value : String := "öäüß";
   begin
      Ahven.Assert (Value = Write_Read (Value), "Read string is not " & Value);
   end String_1;

end Date.Test.Byte_Checker_String;

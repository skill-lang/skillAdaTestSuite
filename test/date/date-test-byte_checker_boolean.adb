package body Date.Test.Byte_Checker_Boolean is

   procedure Initialize (T : in out Test) is
   begin
      Set_Name (T, "Date.Test.Byte_Checker_Boolean");
      Ahven.Framework.Add_Test_Routine (T, True'Access, "True");
      Ahven.Framework.Add_Test_Routine (T, False'Access, "False");
   end Initialize;

   function Write_Read (Value : Boolean) return Boolean is
      Temp_File : ASS_IO.File_Type;
      Temp_Stream : ASS_IO.Stream_Access;
      rval : Boolean;
   begin
      ASS_IO.Create (Temp_File, ASS_IO.Out_File);
      Temp_Stream := ASS_IO.Stream (Temp_File);

      Byte_Writer.Initialize (Temp_Stream);
      Byte_Writer.Write_Boolean (Value);

      ASS_IO.Reset (Temp_File, ASS_IO.In_File);
      Byte_Reader.Initialize (Temp_Stream);
      rval := Byte_Reader.Read_Boolean;

      ASS_IO.Close (Temp_File);

      return rval;
   end Write_Read;

   procedure True is
      Value : Boolean := True;
   begin
      Ahven.Assert (Value = Write_Read (Value), "Read boolean is not " & Boolean'Image (Value));
   end True;

   procedure False is
      Value : Boolean := False;
   begin
      Ahven.Assert (Value = Write_Read (Value), "Read boolean is not " & Boolean'Image (Value));
   end False;

end Date.Test.Byte_Checker_Boolean;

package body Date.Test.Byte_Checker_i32 is

   procedure Initialize (T : in out Test) is
   begin
      Set_Name (T, "Date.Test.Byte_Checker_i32");
      Ahven.Framework.Add_Test_Routine (T, First'Access, "'First");
      Ahven.Framework.Add_Test_Routine (T, Minus_One'Access, "-1");
      Ahven.Framework.Add_Test_Routine (T, Zero'Access, "0");
      Ahven.Framework.Add_Test_Routine (T, Plus_One'Access, "1");
      Ahven.Framework.Add_Test_Routine (T, Last'Access, "'Last");
   end Initialize;

   function Write_Read (Value : i32) return i32 is
      Temp_File : ASS_IO.File_Type;
      Temp_Stream : ASS_IO.Stream_Access;
      rval : i32;
   begin
      ASS_IO.Create (Temp_File, ASS_IO.Out_File);
      Temp_Stream := ASS_IO.Stream (Temp_File);

      Byte_Writer.Initialize (Temp_Stream);
      Byte_Writer.Write_i32 (Value);

      ASS_IO.Reset (Temp_File, ASS_IO.In_File);
      Byte_Reader.Initialize (Temp_Stream);
      rval := Byte_Reader.Read_i32;

      ASS_IO.Close (Temp_File);

      return rval;
   end Write_Read;

   procedure First is
      Value : i32 := i32'First;
   begin
      Ahven.Assert (Value = Write_Read (Value), "Read i32 is not " & i32'Image (Value));
   end First;

   procedure Minus_One is
      Value : i32 := -1;
   begin
      Ahven.Assert (Value = Write_Read (Value), "Read i32 is not " & i32'Image (Value));
   end Minus_One;

   procedure Zero is
      Value : i32 := 0;
   begin
      Ahven.Assert (Value = Write_Read (Value), "Read i32 is not " & i32'Image (Value));
   end Zero;

   procedure Plus_One is
      Value : i32 := 1;
   begin
      Ahven.Assert (Value = Write_Read (Value), "Read i32 is not " & i32'Image (Value));
   end Plus_One;

   procedure Last is
      Value : i32 := i32'Last;
   begin
      Ahven.Assert (Value = Write_Read (Value), "Read i32 is not " & i32'Image (Value));
   end Last;

end Date.Test.Byte_Checker_i32;

package body Date.Internal.Parsers.Byte_Reader is

   Input_Stream : ASS_IO.Stream_Access;

   function Next_Byte return Byte is
      Next : Byte;
   begin
      Byte'Read (Input_Stream, Next);
      return Next;
   end Next_Byte;

   function i32 return Integer is
      Next : Integer;
   begin
      Integer'Read (Input_Stream, Next);
      return Next;
   end i32;

   function v64 return Long is
      Count  : Long := 0;
      Result : Long := 0;
      Bucket : Byte := Next_Byte;
   begin
      while Count < 8 and then 0 /= (Bucket and Byte'First) loop
         Result := Long ((Bucket and Byte'Last) + Byte (7 * Count));
         Count := Count + 1;
         Bucket := Next_Byte;
      end loop;

      if (8 = Result) then
         Result := Long ((Bucket) + Byte (7 * Count));
      else
         Result := Long ((Bucket and Byte'Last) + Byte (7 * Count));
      end if;

      return Result;
   end v64;

   procedure Read (File_Name : String) is
      Input_File : ASS_IO.File_Type;
   begin
      ASS_IO.Open (Input_File, ASS_IO.In_File, File_Name);
      Input_Stream := ASS_IO.Stream (Input_File);

      Ada.Text_IO.Put_Line (Long'Image (v64));
      Ada.Integer_Text_IO.Put (i32);
      ASS_IO.Close (Input_File);
   end Read;

   procedure Write (File_Name : String) is
      Output_File : ASS_IO.File_Type;
      Output_Stream : ASS_IO.Stream_Access;
   begin
      ASS_IO.Open (Output_File, ASS_IO.Out_File, File_Name);
      Output_Stream := ASS_IO.Stream (Output_File);
      Integer'Write (Output_Stream, 4);
      ASS_IO.Close (Output_File);
   end Write;

end Date.Internal.Parsers.Byte_Reader;

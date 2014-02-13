package body Date.Internal.Parsers.Byte_Reader is

   Input_Stream : ASS_IO.Stream_Access;

   function Read_Byte return Byte is
      Next : Byte;
   begin
      Byte'Read (Input_Stream, Next);
      return Next;
   end Read_Byte;

   --  Short_Short_Integer
   function Read_i8 return i8 is
      A : i8 := i8 (Read_Byte);
   begin
      return A;
   end Read_i8;

   --  Short_Integer (Short)
   function Read_i16 return i16 is
      A : i16 := i16 (Read_Byte);
      B : i16 := i16 (Read_Byte);
   begin
      return A * (2**8) + B;
   end Read_i16;

   --  Integer
   function Read_i32 return i32 is
      A : i32 := i32 (Read_Byte);
      B : i32 := i32 (Read_Byte);
      C : i32 := i32 (Read_Byte);
      D : i32 := i32 (Read_Byte);
   begin
      return A * (2**24) + B*(2**16) + C*(2**8) + D;
   end Read_i32;

   --  Long_Integer (Long)
   function Read_i64 return i64 is
      A : i64 := i64 (Read_Byte);
      B : i64 := i64 (Read_Byte);
      C : i64 := i64 (Read_Byte);
      D : i64 := i64 (Read_Byte);
      E : i64 := i64 (Read_Byte);
      F : i64 := i64 (Read_Byte);
      G : i64 := i64 (Read_Byte);
   begin
      return A * (2**48) + B*(2**40) + C*(2**32) + D*(2**24) + E*(2**16) + F*(2**8) + G;
   end Read_i64;

   function Read_v64 return Long is
      type Long_Result is mod 2 ** 64;
      function Convert is new Ada.Unchecked_Conversion (Source => Long_Result, Target => Long);

      Count : Natural := 0;
      Result : Long_Result := 0;
      Bucket : Long_Result := Long_Result (Read_Byte);
   begin
      while (Count < 8 and then 0 /= (Bucket and 16#80#)) loop
         Result := Result or ((Bucket and 16#7f#) * (2 ** (7 * Count)));
         Count := Count + 1;
         Bucket := Long_Result (Read_Byte);
      end loop;

      case Count is
         when 8 => Result := Result or (Bucket * (2 ** (7 * Count)));
         when others => Result := Result or ((Bucket and 16#7f#) * (2 ** (7 * Count)));
      end case;

      return Convert (Result);
   end Read_v64;

   function Read_f32 return f32 is
      Unsupported_Type : exception;
   begin
      raise Unsupported_Type;
      return 0.0;
   end Read_f32;

   function Read_f64 return f64 is
      Unsupported_Type : exception;
   begin
      raise Unsupported_Type;
      return 0.0;
   end Read_f64;

   function Read_String (Length : Integer) return String is
      New_String : String (1 .. Length);
   begin
      for I in Integer range 1 .. Length loop
         New_String (I) := Character'Val (Read_Byte);
      end loop;
      return New_String;
   end Read_String;

   procedure Read (File_Name : String) is
      Input_File : ASS_IO.File_Type;
   begin
      ASS_IO.Open (Input_File, ASS_IO.In_File, File_Name);
      Input_Stream := ASS_IO.Stream (Input_File);

      Ada.Text_IO.Put_Line (Long'Image (Read_v64));

      declare
         String_Length : Integer := Read_i32;
      begin
         Ada.Text_IO.Put_Line (i32'Image (String_Length));
         Ada.Text_IO.Put_Line (Read_String (String_Length));
      end;

      Ada.Text_IO.Put_Line (Long'Image (Read_v64));
      Ada.Text_IO.Put_Line (Long'Image (Read_v64));
      Ada.Text_IO.Put_Line (Long'Image (Read_v64));
      Ada.Text_IO.Put_Line (Long'Image (Read_v64));
      Ada.Text_IO.Put_Line (Long'Image (Read_v64));
      Ada.Text_IO.Put_Line (Long'Image (Read_v64));
      Ada.Text_IO.Put_Line (Long'Image (Read_v64));
      Ada.Text_IO.Put_Line (Long'Image (Read_v64));
      Ada.Text_IO.Put_Line (Long'Image (Read_v64));
      Ada.Text_IO.Put_Line (Long'Image (Read_v64));
      Ada.Text_IO.Put_Line (Long'Image (Read_v64));
      Ada.Text_IO.Put_Line (Long'Image (Read_v64));

      ASS_IO.Close (Input_File);
   end Read;

   procedure Write (File_Name : String) is
      Output_File : ASS_IO.File_Type;
      Output_Stream : ASS_IO.Stream_Access;
   begin
      ASS_IO.Open (Output_File, ASS_IO.Out_File, File_Name);
      Output_Stream := ASS_IO.Stream (Output_File);
      Byte'Write (Output_Stream, Byte (1));
      Byte'Write (Output_Stream, Byte (0));
      Byte'Write (Output_Stream, Byte (0));
      Byte'Write (Output_Stream, Byte (0));
      Byte'Write (Output_Stream, Byte (4));

      declare
         Date : String := "date";
      begin
         for I in Date'Range loop
            Byte'Write (Output_Stream, Character'Pos (Date (I)));
         end loop;
      end;

      Byte'Write (Output_Stream, Byte (100));
      Byte'Write (Output_Stream, Byte (97));
      Byte'Write (Output_Stream, Byte (116));
      Byte'Write (Output_Stream, Byte (101));
      ASS_IO.Close (Output_File);
   end Write;

end Date.Internal.Parsers.Byte_Reader;

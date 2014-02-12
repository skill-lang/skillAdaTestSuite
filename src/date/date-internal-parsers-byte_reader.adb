package body Date.Internal.Parsers.Byte_Reader is

   Input_Stream : ASS_IO.Stream_Access;

   function Next_Byte return Byte is
      Next : Byte;
   begin
      Byte'Read (Input_Stream, Next);
      return Next;
   end Next_Byte;

   --  Short_Short_Integer
   function Next_i8 return i8 is
      A : i8 := i8 (Next_Byte);
   begin
      return A;
   end Next_i8;

   --  Short_Integer (Short)
   function Next_i16 return i16 is
      A : i16 := i16 (Next_Byte);
      B : i16 := i16 (Next_Byte);
   begin
      return A*(2**8) + B;
   end Next_i16;

   --  Integer
   function Next_i32 return i32 is
      A : i32 := i32 (Next_Byte);
      B : i32 := i32 (Next_Byte);
      C : i32 := i32 (Next_Byte);
      D : i32 := i32 (Next_Byte);
   begin
      return A*(2**24) + B*(2**16) + C*(2**8) + D;
   end Next_i32;

   --  Long_Integer (Long)
   function Next_i64 return i64 is
      A : i64 := i64 (Next_Byte);
      B : i64 := i64 (Next_Byte);
      C : i64 := i64 (Next_Byte);
      D : i64 := i64 (Next_Byte);
      E : i64 := i64 (Next_Byte);
      F : i64 := i64 (Next_Byte);
      G : i64 := i64 (Next_Byte);
   begin
      return A*(2**48) + B*(2**40) + C*(2**32) + D*(2**24) + E*(2**16) + F*(2**8) + G;
   end Next_i64;

   function Next_v64 return Long is
      use Interfaces;
      count : Natural := 0;
      rval : Long := 0;
      r : Byte := Next_Byte;
   begin
      while (count < 8 and then 0 /= (r and 16#80#)) loop
         rval := Long ((r and 16#7f#) + 2 ** (7 * count));
         count := count + 1;
         r := Next_Byte;
      end loop;

      case r is
         when 8 => rval := Long (r);
         when others => rval := Long (r and 16#7f#);
      end case;

      rval := rval + 2 ** (7 * count);

      return rval;
   end Next_v64;

   function Next_f32 return f32 is
      Unsupported_Data_Type : exception;
   begin
      raise Unsupported_Data_Type;
      return 0.0;
   end Next_f32;

   function Next_f64 return f64 is
      Unsupported_Data_Type : exception;
   begin
      raise Unsupported_Data_Type;
      return 0.0;
   end Next_f64;

   function Next_String (Length : Integer) return String is
      New_String : String (1 .. Length);
   begin
      for I in Integer range 1 .. Length loop
         New_String (I) := Character'Val (Next_Byte);
      end loop;
      return New_String;
   end Next_String;

   procedure Read (File_Name : String) is
      Input_File : ASS_IO.File_Type;
   begin
      ASS_IO.Open (Input_File, ASS_IO.In_File, File_Name);
      Input_Stream := ASS_IO.Stream (Input_File);

      Ada.Text_IO.Put_Line (Long'Image (Next_v64));

      declare
         String_Length : Integer := Next_i32;
      begin
         Ada.Text_IO.Put_Line (Next_String (String_Length));
      end;

      Ada.Text_IO.Put_Line (Long'Image (Next_v64));
      Ada.Text_IO.Put_Line (Byte'Image (Next_Byte));
      Ada.Text_IO.Put_Line (Byte'Image (Next_Byte));
      Ada.Text_IO.Put_Line (Byte'Image (Next_Byte));
      Ada.Text_IO.Put_Line (Byte'Image (Next_Byte));
      Ada.Text_IO.Put_Line (Byte'Image (Next_Byte));
      Ada.Text_IO.Put_Line (Byte'Image (Next_Byte));
      Ada.Text_IO.Put_Line (Byte'Image (Next_Byte));
      Ada.Text_IO.Put_Line (Byte'Image (Next_Byte));
      Ada.Text_IO.Put_Line (Byte'Image (Next_Byte));
      Ada.Text_IO.Put_Line (Long'Image (Next_v64));
      Ada.Text_IO.Put_Line (Long'Image (Next_v64));

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
      Byte'Write (Output_Stream, Byte (100));
      Byte'Write (Output_Stream, Byte (97));
      Byte'Write (Output_Stream, Byte (116));
      Byte'Write (Output_Stream, Byte (101));
      ASS_IO.Close (Output_File);
   end Write;

end Date.Internal.Parsers.Byte_Reader;

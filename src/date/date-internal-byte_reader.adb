package body Date.Internal.Byte_Reader is

   Input_Stream : ASS_IO.Stream_Access;

   procedure Initialize (pInput_Stream : ASS_IO.Stream_Access) is
   begin
      Input_Stream := pInput_Stream;
   end Initialize;

   function Read_Byte return Byte is
      Next : Byte;
   begin
      Byte'Read (Input_Stream, Next);
      return Next;
   end Read_Byte;

   --  Short_Short_Integer
   function Read_i8 return i8 is
      type Result is mod 2 ** 8;
      function Convert is new Ada.Unchecked_Conversion (Source => Result, Target => i8);

      A : Result := Result (Read_Byte);
   begin
      return Convert (A);
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
      H : i64 := i64 (Read_Byte);
   begin
      return A * (2**56) + B*(2**48) + C*(2**40) + D*(2**32) + E*(2**24) + F*(2**16) + G*(2**8) + H;
   end Read_i64;

   function Read_v64 return v64 is
      type Result is mod 2 ** 64;
      function Convert is new Ada.Unchecked_Conversion (Source => Result, Target => v64);

      Count : Natural := 0;
      rval : Result := 0;
      Bucket : Result := Result (Read_Byte);
   begin
      while (Count < 8 and then 0 /= (Bucket and 16#80#)) loop
         rval := rval or ((Bucket and 16#7f#) * (2 ** (7 * Count)));
         Count := Count + 1;
         Bucket := Result (Read_Byte);
      end loop;

      case Count is
         when 8 => rval := rval or (Bucket * (2 ** (7 * Count)));
         when others => rval := rval or ((Bucket and 16#7f#) * (2 ** (7 * Count)));
      end case;

      return Convert (rval);
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

   function Read_Boolean return Boolean is
      Unexcepted_Value : exception;
   begin
      case Read_Byte is
         when 16#ff# => return True;
         when 16#00# => return False;
         when others => raise Unexcepted_Value;
      end case;
   end Read_Boolean;

   function Read_String (Length : Integer) return String is
      New_String : String (1 .. Length);
   begin
      for I in Integer range 1 .. Length loop
         New_String (I) := Character'Val (Read_Byte);
      end loop;
      return New_String;
   end Read_String;

end Date.Internal.Byte_Reader;

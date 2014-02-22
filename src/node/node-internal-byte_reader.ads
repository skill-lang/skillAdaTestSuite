with Ada.Unchecked_Conversion;
with Interfaces;

package Node.Internal.Byte_Reader is

   procedure Initialize (pInput_Stream : ASS_IO.Stream_Access);

   function Read_i8 return i8;
   function Read_i16 return i16;
   function Read_i32 return i32;
   function Read_i64 return i64;

   function Read_v64 return v64;

   function Read_f32 return f32;
   function Read_f64 return f64;

   function Read_Boolean return Boolean;
   function Read_String (Length : Integer) return String;

   procedure Skip_Bytes (Length : Long);

private

   function Read_Byte return Byte;

end Node.Internal.Byte_Reader;

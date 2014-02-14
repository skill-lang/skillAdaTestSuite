with Ada.Streams.Stream_IO;
with Ada.Unchecked_Conversion;
with Interfaces;

--  https://groups.google.com/forum/#!topic/comp.lang.ada/lZcb8pp0X_Q

package Date.Internal.Byte_Reader is

   package ASS_IO renames Ada.Streams.Stream_IO;

   subtype Byte is Interfaces.Unsigned_8;

   procedure Initialize (pInput_Stream : ASS_IO.Stream_Access);

   function Read_i8 return i8;
   function Read_i16 return i16;
   function Read_i32 return i32;
   function Read_i64 return i64;

   function Read_v64 return v64;

   function Read_f32 return f32;
   function Read_f64 return f64;

   function Read_String (Length : Integer) return String;

private

   function Read_Byte return Byte;

end Date.Internal.Byte_Reader;

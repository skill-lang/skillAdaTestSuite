with Ada.Integer_Text_IO;
with Ada.Text_IO;

with Ada.Streams.Stream_IO;
with Ada.Unchecked_Conversion;

package Date.Internal.Parsers.Byte_Reader is

   package ASS_IO renames Ada.Streams.Stream_IO;

   procedure Read (File_Name : String);

   function Read_Byte return Byte;

   function Read_i8 return i8;
   function Read_i16 return i16;
   function Read_i32 return i32;
   function Read_i64 return i64;

   function Read_v64 return v64;

   function Read_f32 return f32;
   function Read_f64 return f64;

   function Read_String (Length : Integer) return String;

   procedure Write (File_Name : String);

end Date.Internal.Parsers.Byte_Reader;

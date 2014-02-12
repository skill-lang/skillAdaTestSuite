with Ada.Streams.Stream_IO;
with Ada.Text_IO;
with Ada.Integer_Text_IO;

package Date.Internal.Parsers.Byte_Reader is

   package ASS_IO renames Ada.Streams.Stream_IO;

   procedure Read (File_Name : String);

   function Next_Byte return Byte;

   function Next_i8 return i8;
   function Next_i16 return i16;
   function Next_i32 return i32;
   function Next_i64 return i64;

   function Next_v64 return v64;

   function Next_f32 return f32;
   function Next_f64 return f64;

   function Next_String (Length : Integer) return String;

   procedure Write (File_Name : String);

end Date.Internal.Parsers.Byte_Reader;

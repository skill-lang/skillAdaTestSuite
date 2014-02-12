with Ada.Streams.Stream_IO;
with Ada.Text_IO;
with Ada.Integer_Text_IO;

package Date.Internal.Parsers.Byte_Reader is

   package ASS_IO renames Ada.Streams.Stream_IO;

   procedure Read (File_Name : String);

   function Next_Byte return Byte;
   function i32 return Integer;
   function v64 return Long;

   procedure Write (File_Name : String);

end Date.Internal.Parsers.Byte_Reader;

with Ada.Streams.Stream_IO;
with Date.Internal.Byte_Reader;

with Ada.Text_IO;

package Date.Internal.File_Parser is

   package ASS_IO renames Ada.Streams.Stream_IO;

   procedure Read (File_Name : String);

   procedure Read_String_Block;
   procedure Read_Type_Block;

end Date.Internal.File_Parser;

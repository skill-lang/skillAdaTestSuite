with Date.Internal.Byte_Reader;
with Date.Internal.String_Pool;

with Ada.Text_IO;

package Date.Internal.File_Parser is

   procedure Read (File_Name : String);

private

   function Read_String_Block return String_Pool_Type;

   procedure Read_Type_Block;

end Date.Internal.File_Parser;

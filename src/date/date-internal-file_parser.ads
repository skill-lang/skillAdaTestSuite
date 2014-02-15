with Date.Internal.Byte_Reader;

with Ada.Text_IO;

package Date.Internal.File_Parser is

   procedure Read (File_Name : String);

private

   procedure Read_String_Block;
   procedure Read_Type_Block;

end Date.Internal.File_Parser;

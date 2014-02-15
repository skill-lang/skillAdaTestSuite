with Ada.Unchecked_Deallocation;
with Date.Internal.Byte_Reader;

with Ada.Text_IO;

package Date.Internal.File_Parser is

   procedure Read (File_Name : String);

private

   function Read_String_Block return String_Pool_Type;
   procedure Next_String_Pool (String_Pool : in out String_Pool_Type_Access);

   procedure Read_Type_Block;

end Date.Internal.File_Parser;

with Ada.Text_IO;
with Date.Internal.File_Parser;
with Date.Internal.String_Pool;

with Ada.Streams.Stream_IO;
with Date.Internal.Byte_Writer;

package Date.Internal.Serializable_State is

   procedure Read (File_Name : String);

   procedure Write (File_Name : String);

end Date.Internal.Serializable_State;

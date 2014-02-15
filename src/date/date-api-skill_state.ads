with Ada.Text_IO;
with Date.Internal.File_Parser;

with Ada.Streams.Stream_IO;
with Date.Internal.Byte_Writer;

package Date.Api.Skill_State is

   procedure Read (File_Name : String);

   package ASS_IO renames Ada.Streams.Stream_IO;

   procedure Write (File_Name : String);

end Date.Api.Skill_State;

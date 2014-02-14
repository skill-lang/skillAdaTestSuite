with Ada.Text_IO;
with Date.Internal.File_Parser;

package Date.Api.Skill_State is

   procedure Read (File_Name : String);

   procedure Write (File_Name : String);

end Date.Api.Skill_State;

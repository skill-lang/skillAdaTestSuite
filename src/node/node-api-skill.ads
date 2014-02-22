with Node.Internal.File_Parser;

package Node.Api.Skill is

   type Node_Objects is array (Natural range <>) of Node_Object;

   procedure Read (State : access Skill_State; File_Name : String);

   function Get_Nodes (State : access Skill_State) return Node_Objects;

end Node.Api.Skill;

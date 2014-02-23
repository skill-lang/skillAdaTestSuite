with Node.Internal.File_Parser;

package Node.Api.Skill is

   type Node_Instances is array (Natural range <>) of Node_Instance;

   procedure Read (State : access Skill_State; File_Name : String);

   function Get_Nodes (State : access Skill_State) return Node_Instances;

end Node.Api.Skill;

with Date.Internal.File_Parser;

package Date.Internal.Serializable_State is

   procedure Read (State : Skill_State; File_Name : String);
   procedure Write (State : Skill_State; File_Name : String);

end Date.Internal.Serializable_State;

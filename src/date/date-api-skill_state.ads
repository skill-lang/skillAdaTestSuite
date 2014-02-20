with Date.Internal.Serializable_State;

package Date.Api.Skill_State is

   procedure Create;
   procedure Read (State : Date.Skill_State; File_Name : String);
   procedure Write (State : Date.Skill_State; File_Name : String);

end Date.Api.Skill_State;

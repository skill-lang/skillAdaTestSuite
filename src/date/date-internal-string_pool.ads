package Date.Internal.String_Pool is

   procedure Append (State : Skill_State; Next_String : String);

   function Get (State : Skill_State; I : Long) return SU.Unbounded_String;
   function Get (State : Skill_State; I : Long) return String;

end Date.Internal.String_Pool;

package body Date.Internal.String_Pool is

   procedure Append (State : Skill_State; Next_String : String) is
   begin
      State.String_Pool.Append (New_Item => SU.To_Unbounded_String (Next_String));
   end Append;

   function Get (State : Skill_State; I : Long) return SU.Unbounded_String is
   begin
--      Ada.Text_IO.Put_Line (State.String_Pool.Length'Img);
      return State.String_Pool.Element (Positive (I));
   end;
   function Get (State : Skill_State; I : Long) return String is
      (SU.To_String (State.String_Pool.Element (Positive (I))));

end Date.Internal.String_Pool;

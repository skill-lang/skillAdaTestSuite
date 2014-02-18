with Ada.Text_IO;
with Date;
with Date.Api.Skill_State;

procedure Main is
   use Date;

   State_1 : Skill_State := new Skill_State_Type;
   State_2 : Skill_State := new Skill_State_Type;
   State_3 : Skill_State := new Skill_State_Type;

   package Skill_State renames Date.Api.Skill_State;
begin
   Ada.Text_IO.Put_Line (" >>> main:");
   Ada.Text_IO.New_Line;

   State_1.x := SU.To_Unbounded_String ("state_1");
   Skill_State.Read (State_1, "resources/date-example.sf");

   Ada.Text_IO.New_Line;

   State_2.x := SU.To_Unbounded_String ("state_2");
   Skill_State.Read (State_2, "resources/twoNodeBlocks.sf");

   Ada.Text_IO.New_Line;

   State_3.x := SU.To_Unbounded_String ("state_3");
   Skill_State.Read (State_3, "resources/date-example.sf");

--   Skill_State.Write ("zzz-ada-test.sf");
--   Skill_State.Read ("zzz-ada-test.sf");
end Main;

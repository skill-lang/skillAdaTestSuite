with Node;
with Node.Api.Skill_State;

with Ada.Text_IO;

procedure Main is
   use Node;
   use Node.Api;

   State_1 : access Serializable_State := new Serializable_State;
   State_2 : access Serializable_State := new Serializable_State;
begin

   Ada.Text_IO.Put_Line (" >>> main:");
   Ada.Text_IO.New_Line;

--   Skill_State.Read (State_1, "resources/date-example.sf");
   Skill_State.Read (State_2, "resources/twoNodeBlocks.sf");

end Main;

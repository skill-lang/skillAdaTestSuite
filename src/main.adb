with Node;
with Node.Api.Skill;

with Ada.Text_IO;

procedure Main is
   use Node;
   use Node.Api;

   A : access Skill_State := new Skill_State;
   B : access Node_Object := new Node_Object'(id => 2);
begin

   Ada.Text_IO.Put_Line (" >>> main:");
   Ada.Text_IO.New_Line;

--   Skill.Read (A, "resources/date-example.sf");

   Skill.Read (A, "resources/twoNodeBlocks.sf");

end Main;

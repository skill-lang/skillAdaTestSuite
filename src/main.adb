with Node;
with Node.Api.Skill;

with Ada.Text_IO;

procedure Main is
   package Skill renames Node.Api.Skill;
   use Node;
   use Skill;

   State : access Skill_State := new Skill_State;
   Object : Node_Instance := (id => 2);
begin

   Ada.Text_IO.Put_Line (" >>> main:");
   Ada.Text_IO.New_Line;

--   Skill.Read (State, "resources/date-example.sf");

   declare
      File_Name : String := "resources/twoNodeBlocks.sf";
   begin
      Ada.Text_IO.Put_Line (File_Name);
      Skill.Read (State, File_Name);
   end;

   declare
      X : Node_Instances := Skill.Get_Nodes (State);
   begin
      for I in X'Range loop
         Ada.Text_IO.Put_Line (X (I).id'Img);
      end loop;
   end;

end Main;

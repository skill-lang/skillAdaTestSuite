with Ada.Text_IO;
with Date;
with Date.Api.Skill_State;

procedure Main is
   use Date;

   State_1 : Skill_State := new Skill_State_Type;
   State_2 : Skill_State := new Skill_State_Type;

   package Skill_State renames Date.Api.Skill_State;
begin
   Ada.Text_IO.Put_Line (" >>> main:");
   Ada.Text_IO.New_Line;

   State_1.x := SU.To_Unbounded_String ("state_1");
   Skill_State.Read (State_1, "resources/date-example.sf");

   for I in 1 .. Natural (State_1.Date_Storage_Pool.Length) loop
      declare
         X : Date_Type_Access := State_1.Date_Storage_Pool.Element (I);
      begin
         Ada.Text_IO.Put_Line (X.date'Img);
      end;
   end loop;

   Ada.Text_IO.New_Line;

   State_2.x := SU.To_Unbounded_String ("state_2");
   Skill_State.Read (State_2, "resources/twoNodeBlocks.sf");

   for I in 1 .. Natural (State_2.Node_Storage_Pool.Length) loop
      declare
         X : Node_Type_Access := State_2.Node_Storage_Pool.Element (I);
      begin
         Ada.Text_IO.Put_Line (X.id'Img);
      end;
   end loop;

--   Skill_State.Write ("zzz-ada-test.sf");
--   Skill_State.Read ("zzz-ada-test.sf");
end Main;

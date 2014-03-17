package body Test_Colored_Nodes.Read is

   procedure Initialize (T : in out Test) is
   begin
      Set_Name (T, "Test_Colored_Nodes.Read");
      Ahven.Framework.Add_Test_Routine (T, Node_1'Access, "1. node: id = 23");
      Ahven.Framework.Add_Test_Routine (T, Node_2'Access, "2. node: id = 42");
   end Initialize;

   procedure Node_1 is
      State : access Skill_State := new Skill_State;
   begin
      Skill.Read (State, "resources/coloredNodes.sf");

      declare
         X : Node_Type_Access := Skill.Get_Node (State, 1);
      begin
         Ahven.Assert (X.Get_Id = 23, "'first node'.Get_Id is not 23.");
      end;
   end Node_1;

   procedure Node_2 is
      State : access Skill_State := new Skill_State;
   begin
      Skill.Read (State, "resources/coloredNodes.sf");

      declare
         X : Node_Type_Access := Skill.Get_Node (State, 2);
      begin
         Ahven.Assert (X.Get_Id = 42, "'second node'.Get_Id is not 42.");
      end;
   end Node_2;

end Test_Colored_Nodes.Read;

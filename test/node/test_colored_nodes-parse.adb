package body Test_Colored_Nodes.Parse is

   procedure Initialize (T : in out Test) is
   begin
      Set_Name (T, "Test_Colored_Nodes.Parse");
      Ahven.Framework.Add_Test_Routine (T, Node_1'Access, "1. node: id = 23");
      Ahven.Framework.Add_Test_Routine (T, Node_2'Access, "2. node: id = 42");

      Skill.Read (T.State, "resources/coloredNodes.sf");
   end Initialize;

   procedure Node_1 (T : in out Ahven.Framework.Test_Case'Class) is
      State : access Skill_State := Test (T).State;
      X : Node_Type_Accesses := Skill.Get_Nodes (State);
   begin
      Ahven.Assert (X (1).Get_Id = 23, "'first node'.Get_Id is not 23.");
   end Node_1;

   procedure Node_2 (T : in out Ahven.Framework.Test_Case'Class) is
      State : access Skill_State := Test (T).State;
      X : Node_Type_Accesses := Skill.Get_Nodes (State);
   begin
      Ahven.Assert (X (2).Get_Id = 42, "'second node'.Get_Id is not 42.");
   end Node_2;

end Test_Colored_Nodes.Parse;

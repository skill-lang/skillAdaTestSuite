package body Test_Node.Read is

   procedure Initialize (T : in out Test) is
   begin
      Set_Name (T, "Test_Node.Read");
      Ahven.Framework.Add_Test_Routine (T, Node_1'Access, "1. node: id = 23");
      Ahven.Framework.Add_Test_Routine (T, Node_2'Access, "2. node: id = 42");
      Ahven.Framework.Add_Test_Routine (T, Node_3'Access, "3. node: id = -1");
      Ahven.Framework.Add_Test_Routine (T, Node_4'Access, "4. node: id = 2");
   end Initialize;

   procedure Node_1 is
      State : access Skill_State := new Skill_State;
   begin
      Skill.Read (State, "resources/twoNodeBlocks.sf");

      declare
         X : Node_Type_Accesses := Skill.Get_Nodes (State);
      begin
         Ahven.Assert (X (1).Get_Id = 23, "'first node'.Get_Id is not 23.");
      end;
   end Node_1;

   procedure Node_2 is
      State : access Skill_State := new Skill_State;
   begin
      Skill.Read (State, "resources/twoNodeBlocks.sf");

      declare
         X : Node_Type_Accesses := Skill.Get_Nodes (State);
      begin
         Ahven.Assert (X (2).Get_Id = 42, "'second node'.Get_Id is not 42.");
      end;
   end Node_2;

   procedure Node_3 is
      State : access Skill_State := new Skill_State;
   begin
      Skill.Read (State, "resources/twoNodeBlocks.sf");

      declare
         X : Node_Type_Accesses := Skill.Get_Nodes (State);
      begin
         Ahven.Assert (X (3).Get_Id = -1, "'third node'.Get_Id is not -1.");
      end;
   end Node_3;

   procedure Node_4 is
      State : access Skill_State := new Skill_State;
   begin
      Skill.Read (State, "resources/twoNodeBlocks.sf");

      declare
         X : Node_Type_Accesses := Skill.Get_Nodes (State);
      begin
         Ahven.Assert (X (4).Get_Id = 2, "'fourth node'.Get_Id is not 2.");
      end;
   end Node_4;

end Test_Node.Read;

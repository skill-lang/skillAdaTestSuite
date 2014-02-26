package body Node.Test.Parse is

   package Skill renames Node.Api.Skill;
   use Node;
   use Skill;

   procedure Initialize (T : in out Test) is
   begin
      Set_Name (T, "Node.Test.Parse");
      Ahven.Framework.Add_Test_Routine (T, Node_1'Access, "1. node: id = 23");
      Ahven.Framework.Add_Test_Routine (T, Node_2'Access, "2. node: id = 42");
      Ahven.Framework.Add_Test_Routine (T, Node_3'Access, "3. node: id = -1");
      Ahven.Framework.Add_Test_Routine (T, Node_4'Access, "4. node: id = 2");

      Skill.Read (T.State, "resources/twoNodeBlocks.sf");
   end Initialize;

   procedure Node_1 (T : in out Ahven.Framework.Test_Case'Class) is
      X : Node_Type_Accesses := Skill.Get_Nodes (Test (T).State);
   begin
      Ahven.Assert (X (1).id = 23, "'first node'.id is not 23.");
   end Node_1;

   procedure Node_2 (T : in out Ahven.Framework.Test_Case'Class) is
      X : Node_Type_Accesses := Skill.Get_Nodes (Test (T).State);
   begin
      Ahven.Assert (X (2).id = 42, "'second node'.id is not 42.");
   end Node_2;

   procedure Node_3 (T : in out Ahven.Framework.Test_Case'Class) is
      X : Node_Type_Accesses := Skill.Get_Nodes (Test (T).State);
   begin
      Ahven.Assert (X (3).id = -1, "'third node'.id is not -1.");
   end Node_3;

   procedure Node_4 (T : in out Ahven.Framework.Test_Case'Class) is
      X : Node_Type_Accesses := Skill.Get_Nodes (Test (T).State);
   begin
      Ahven.Assert (X (4).id = 2, "'fourth node'.id is not 2.");
   end Node_4;

end Node.Test.Parse;

package body Node.Test.Parse_Test is

   package Skill renames Node.Api.Skill;
   use Node;
   use Skill;

   procedure Initialize (T : in out Test) is
   begin
      Set_Name (T, "Node.Test.Parse_Test");
      Ahven.Framework.Add_Test_Routine (T, First_Node'Access, "first node");
      Ahven.Framework.Add_Test_Routine (T, Second_Node'Access, "second node");
      Ahven.Framework.Add_Test_Routine (T, Third_Node'Access, "third node");
      Ahven.Framework.Add_Test_Routine (T, Fourth_Node'Access, "fourth node");

      Skill.Read (T.State, "resources/twoNodeBlocks.sf");
   end Initialize;

   procedure First_Node (T : in out Ahven.Framework.Test_Case'Class) is
      X : Node_Instances := Skill.Get_Nodes (Test (T).State);
   begin
      Ahven.Assert (X (1).id = 23, "Node is not 23.");
   end First_Node;

   procedure Second_Node (T : in out Ahven.Framework.Test_Case'Class) is
      X : Node_Instances := Skill.Get_Nodes (Test (T).State);
   begin
      Ahven.Assert (X (2).id = 42, "Node is not 42.");
   end Second_Node;

   procedure Third_Node (T : in out Ahven.Framework.Test_Case'Class) is
      X : Node_Instances := Skill.Get_Nodes (Test (T).State);
   begin
      Ahven.Assert (X (3).id = -1, "Node is not -1.");
   end Third_Node;

   procedure Fourth_Node (T : in out Ahven.Framework.Test_Case'Class) is
      X : Node_Instances := Skill.Get_Nodes (Test (T).State);
   begin
      Ahven.Assert (X (4).id = 2, "Node is not 2.");
   end Fourth_Node;

end Node.Test.Parse_Test;

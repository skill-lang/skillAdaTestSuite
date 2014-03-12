package body Test_Foreign.Read is

   procedure Initialize (T : in out Test) is
   begin
      Set_Name (T, "Test_Foreign.Read");
      Ahven.Framework.Add_Test_Routine (T, Aircraft'Access, "aircraft.sf");
      Ahven.Framework.Add_Test_Routine (T, Annotation_Test'Access, "annotationTest.sf");
      Ahven.Framework.Add_Test_Routine (T, Colored_Nodes'Access, "coloredNodes.sf");
      Ahven.Framework.Add_Test_Routine (T, Constant_Maybe_Wrong'Access, "constant.sf");
      Ahven.Framework.Add_Test_Routine (T, Container'Access, "container.sf");
      Ahven.Framework.Add_Test_Routine (T, Date_Example'Access, "date-example.sf");
      Ahven.Framework.Add_Test_Routine (T, Four_Colored_Nodes'Access, "fourColoredNodes.sf");
      Ahven.Framework.Add_Test_Routine (T, Local_Base_Pool_Start_Index'Access, "localBasePoolStartIndex.sf");
      Ahven.Framework.Add_Test_Routine (T, Node'Access, "node.sf");
      Ahven.Framework.Add_Test_Routine (T, Null_Annotation'Access, "nullAnnotation.sf");
      Ahven.Framework.Add_Test_Routine (T, Two_Node_Blocks'Access, "twoNodeBlocks.sf");
   end Initialize;

   procedure Aircraft is
      State : access Skill_State := new Skill_State;
   begin
      Skill.Read (State, "resources/aircraft.sf");
   end Aircraft;

   procedure Annotation_Test is
      State : access Skill_State := new Skill_State;
   begin
      Skill.Read (State, "resources/annotationTest.sf");
   end Annotation_Test;

   procedure Colored_Nodes is
      State : access Skill_State := new Skill_State;
   begin
      Skill.Read (State, "resources/coloredNodes.sf");
   end Colored_Nodes;

   procedure Constant_Maybe_Wrong is
      State : access Skill_State := new Skill_State;
   begin
      Skill.Read (State, "resources/constant.sf");
   end Constant_Maybe_Wrong;

   procedure Container is
      State : access Skill_State := new Skill_State;
   begin
      Skill.Read (State, "resources/container.sf");
   end Container;

   procedure Date_Example is
      State : access Skill_State := new Skill_State;
   begin
      Skill.Read (State, "resources/date-example.sf");
   end Date_Example;

   procedure Four_Colored_Nodes is
      State : access Skill_State := new Skill_State;
   begin
      Skill.Read (State, "resources/fourColoredNodes.sf");
   end Four_Colored_Nodes;

   procedure Local_Base_Pool_Start_Index is
      State : access Skill_State := new Skill_State;
   begin
      Skill.Read (State, "resources/localBasePoolStartIndex.sf");
   end Local_Base_Pool_Start_Index;

   procedure Node is
      State : access Skill_State := new Skill_State;
   begin
      Skill.Read (State, "resources/node.sf");
   end Node;

   procedure Null_Annotation is
      State : access Skill_State := new Skill_State;
   begin
      Skill.Read (State, "resources/nullAnnotation.sf");
   end Null_Annotation;

   procedure Two_Node_Blocks is
      State : access Skill_State := new Skill_State;
   begin
      Skill.Read (State, "resources/twoNodeBlocks.sf");
   end Two_Node_Blocks;

end Test_Foreign.Read;

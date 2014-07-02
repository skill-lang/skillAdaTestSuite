package body Test_Null_Annotation.Read is

   procedure Initialize (T : in out Test) is
   begin
      Set_Name (T, "Test_Null_Annotation.Read");
      Ahven.Framework.Add_Test_Routine (T, Null_Annotation'Access, "null annotation");
   end Initialize;

   procedure Null_Annotation (T : in out Ahven.Framework.Test_Case'Class) is
      State : access Skill_State := new Skill_State;
      File_Name : constant String := "resources/nullAnnotation.sf";
   begin
      Skill.Read (State, File_Name);

      declare
         Test : Test_Type_Access := Skill.Get_Test (State, 1);
      begin
         Ahven.Assert (null = Test.Get_F, "annotation is not null");
      end;
   end Null_Annotation;

end Test_Null_Annotation.Read;

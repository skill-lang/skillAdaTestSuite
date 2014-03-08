package body Test_Annotation.Write is

   procedure Initialize (T : in out Test) is
   begin
      Set_Name (T, "Test_Annotation.Write");
      Ahven.Framework.Add_Test_Routine (T, Read_And_Write'Access, "read and write");
      Ahven.Framework.Add_Test_Routine (T, Check_Annotation'Access, "check annotation");
   end Initialize;

   procedure Read_And_Write is
      State : access Skill_State := new Skill_State;
   begin
      Skill.Read (State, "resources/annotationTest.sf");
      Skill.Write (State, "test/write-annotationTest.sf");
   end Read_And_Write;

   procedure Check_Annotation is
      State : access Skill_State := new Skill_State;
   begin
      Skill.Read (State, "test/write-annotationTest.sf");

      declare
         Tests : Test_Type_Accesses := Skill.Get_Tests (State);
         Dates : Date_Type_Accesses := Skill.Get_Dates (State);
         X : Date_Type_Access := Date_Type_Access (Tests (1).Get_F);
         Y : Date_Type_Access := Dates (1);
      begin
         Ahven.Assert (X = Y, "objects are not equal");
      end;
   end Check_Annotation;

end Test_Annotation.Write;

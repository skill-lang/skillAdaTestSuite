package body Test_Annotation.Parse is

   procedure Initialize (T : in out Test) is
   begin
      Set_Name (T, "Test_Annotation.Parse");
      Ahven.Framework.Add_Test_Routine (T, Check_Annotation'Access, "check annotation");
      Ahven.Framework.Add_Test_Routine (T, Change_Annotation'Access, "change annotation");
      Ahven.Framework.Add_Test_Routine (T, Annotation_Type_Safety'Access, "annotation type-safety");

      Skill.Read (T.State, "resources/annotationTest.sf");
   end Initialize;

   procedure Check_Annotation (T : in out Ahven.Framework.Test_Case'Class) is
      State : access Skill_State := Test (T).State;
      Tests : Test_Type_Accesses := Skill.Get_Tests (State);
      Dates : Date_Type_Accesses := Skill.Get_Dates (State);
      X : Date_Type_Access := Date_Type_Access (Tests (1).Get_F);
      Y : Date_Type_Access := Dates (1);
   begin
      Ahven.Assert (X = Y, "objects are not equal");
   end Check_Annotation;

   procedure Change_Annotation (T : in out Ahven.Framework.Test_Case'Class) is
      State : access Skill_State := Test (T).State;
      Tests : Test_Type_Accesses := Skill.Get_Tests (State);
      Dates : Date_Type_Accesses := Skill.Get_Dates (State);
      X : Test_Type_Access := Tests (1);
      Y : Date_Type_Access := Dates (2);
   begin
      X.Set_F (Skill_Type_Access (Y));
      Ahven.Assert (X.Get_F = Skill_Type_Access (Y), "objects are not equal");
   end Change_Annotation;

   procedure Annotation_Type_Safety (T : in out Ahven.Framework.Test_Case'Class) is
      State : access Skill_State := Test (T).State;
      Tests : Test_Type_Accesses := Skill.Get_Tests (State);
      Dates : Date_Type_Accesses := Skill.Get_Dates (State);
      X : Test_Type_Access := Tests (1);
   begin
      Ahven.Assert (X.Get_F /= Skill_Type_Access (X), "objects are not equal");
   end Annotation_Type_Safety;

end Test_Annotation.Parse;

package body Annotation.Test.Parse is

   package Skill renames Annotation.Api.Skill;
   use Annotation;
   use Skill;

   procedure Initialize (T : in out Test) is
   begin
      Set_Name (T, "Annotation.Test.Parse");
      Ahven.Framework.Add_Test_Routine (T, Check_Annotation'Access, "check annotation");
      Ahven.Framework.Add_Test_Routine (T, Change_Annotation'Access, "change annotation");
      Ahven.Framework.Add_Test_Routine (T, Annotation_Type_Safety'Access, "annotation type-safety");

      Skill.Read (T.State, "resources/annotationTest.sf");
   end Initialize;

   procedure Check_Annotation (T : in out Ahven.Framework.Test_Case'Class) is
      Tests : Test_Type_Accesses := Skill.Get_Tests (Test (T).State);
      Dates : Date_Type_Accesses := Skill.Get_Dates (Test (T).State);
      X : Date_Type_Access := Date_Type_Access (Tests (1).f);
      Y : Date_Type_Access := Dates (1);
   begin
      Ahven.Assert (X = Y, "objects are not equal");
   end Check_Annotation;

   procedure Change_Annotation (T : in out Ahven.Framework.Test_Case'Class) is
      Tests : Test_Type_Accesses := Skill.Get_Tests (Test (T).State);
      Dates : Date_Type_Accesses := Skill.Get_Dates (Test (T).State);
      X : Test_Type_Access := Tests (1);
      Y : Date_Type_Access := Dates (2);
   begin
      X.f := Skill_Type_Access (Y);
      Ahven.Assert (X.f = Skill_Type_Access (Y), "objects are not equal");
   end Change_Annotation;

   procedure Annotation_Type_Safety (T : in out Ahven.Framework.Test_Case'Class) is
      Tests : Test_Type_Accesses := Skill.Get_Tests (Test (T).State);
      Dates : Date_Type_Accesses := Skill.Get_Dates (Test (T).State);
      X : Test_Type_Access := Tests (1);
   begin
      Ahven.Assert (X.f /= Skill_Type_Access (X), "objects are not equal");
   end Annotation_Type_Safety;

end Annotation.Test.Parse;

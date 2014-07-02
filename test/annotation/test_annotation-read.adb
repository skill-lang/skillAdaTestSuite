package body Test_Annotation.Read is

   procedure Initialize (T : in out Test) is
   begin
      Set_Name (T, "Test_Annotation.Read");
      Ahven.Framework.Add_Test_Routine (T, Check_Annotation'Access, "check annotation");
      Ahven.Framework.Add_Test_Routine (T, Change_Annotation'Access, "change annotation");
      Ahven.Framework.Add_Test_Routine (T, Annotation_Type_Safety'Access, "annotation type-safety");
   end Initialize;

   procedure Check_Annotation is
      State : access Skill_State := new Skill_State;
      File_Name : constant String := "resources/annotationTest.sf";
   begin
      Skill.Read (State, File_Name);

      declare
         Test : Test_Type_Access := Skill.Get_Test (State, 1);
         Date : Date_Type_Access := Skill.Get_Date (State, 1);
         X : Date_Type_Access := Date_Type_Access (Test.Get_F);
         Y : Date_Type_Access := Date;
      begin
         Ahven.Assert (X = Y, "objects are not equal");
      end;
   end Check_Annotation;

   procedure Change_Annotation is
      State : access Skill_State := new Skill_State;
      File_Name : constant String := "resources/annotationTest.sf";
   begin
      Skill.Read (State, File_Name);

      declare
         Test : Test_Type_Access := Skill.Get_Test (State, 1);
         Date : Date_Type_Access := Skill.Get_Date (State, 2);
         X : Test_Type_Access := Test;
         Y : Date_Type_Access := Date;
      begin
         X.Set_F (Skill_Type_Access (Y));
         Ahven.Assert (X.Get_F = Skill_Type_Access (Y), "objects are not equal");
      end;
   end Change_Annotation;

   procedure Annotation_Type_Safety is
      State : access Skill_State := new Skill_State;
      File_Name : constant String := "resources/annotationTest.sf";
   begin
      Skill.Read (State, File_Name);

      declare
         Test : Test_Type_Access := Skill.Get_Test (State, 1);
      begin
         Ahven.Assert (Test.Get_F /= Skill_Type_Access (Test), "objects are equal");
      end;
   end Annotation_Type_Safety;

end Test_Annotation.Read;

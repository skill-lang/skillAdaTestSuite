package body Test_Annotation.Write is

   File_Name : constant String := "tmp/test-annotation-write.sf";

   procedure Initialize (T : in out Test) is
   begin
      Set_Name (T, "Test_Annotation.Write");
      Ahven.Framework.Add_Test_Routine (T, Read_Written'Access, "read written");
      Ahven.Framework.Add_Test_Routine (T, Check_Annotation'Access, "check annotation");
      Ahven.Framework.Add_Test_Routine (T, Annotation_Type_Safety'Access, "annotation type-safety");
   end Initialize;

   procedure Set_Up (T : in out Test) is
      State : access Skill_State := new Skill_State;
   begin
      Skill.Read (State, "resources/annotationTest.sf");
      Skill.Write (State, File_Name);
   end Set_Up;

   procedure Tear_Down (T : in out Test) is
   begin
      Ada.Directories.Delete_File (File_Name);
   end Tear_Down;

   procedure Read_Written (T : in out Ahven.Framework.Test_Case'Class) is
      State : access Skill_State := new Skill_State;
   begin
      Skill.Read (State, File_Name);
   end Read_Written;

   procedure Check_Annotation (T : in out Ahven.Framework.Test_Case'Class) is
      State : access Skill_State := new Skill_State;
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

   procedure Annotation_Type_Safety (T : in out Ahven.Framework.Test_Case'Class) is
      State : access Skill_State := new Skill_State;
   begin
      Skill.Read (State, File_Name);

      declare
         Test : Test_Type_Access := Skill.Get_Test (State, 1);
      begin
         Ahven.Assert (Test.Get_F /= Skill_Type_Access (Test), "objects are equal");
      end;
   end Annotation_Type_Safety;

end Test_Annotation.Write;

package body Test_Null_Annotation.Write is

   File_Name : constant String := "tmp/test-null-annotation-write.sf";

   procedure Initialize (T : in out Test) is
   begin
      Set_Name (T, "Test_Null_Annotation.Write");
      Ahven.Framework.Add_Test_Routine (T, Read_Written'Access, "read written");
      Ahven.Framework.Add_Test_Routine (T, Null_Annotation'Access, "null annotation");
   end Initialize;

   procedure Set_Up (T : in out Test) is
      State : access Skill_State := new Skill_State;
   begin
      Skill.Read (State, "resources/nullAnnotation.sf");
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

   procedure Null_Annotation (T : in out Ahven.Framework.Test_Case'Class) is
      State : access Skill_State := new Skill_State;
   begin
      Skill.Read (State, File_Name);

      declare
         Test : Test_Type_Access := Skill.Get_Test (State, 1);
      begin
         Ahven.Assert (null = Test.Get_F, "annotation is not null");
      end;
   end Null_Annotation;

end Test_Null_Annotation.Write;

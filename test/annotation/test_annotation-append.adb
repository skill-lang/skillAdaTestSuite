with Ada.Text_IO;

package body Test_Annotation.Append is

   File_Name : constant String := "tmp/test-append-annotation.sf";

   procedure Initialize (T : in out Test) is
   begin
      Set_Name (T, "Test_Annotation.Append");
      Ahven.Framework.Add_Test_Routine (T, Append_Test_1'Access, "append test 1");
      Ahven.Framework.Add_Test_Routine (T, Append_Test_2'Access, "append test 2");
      Ahven.Framework.Add_Test_Routine (T, Append_Test_3'Access, "append test 3");
   end Initialize;

   procedure Set_Up (T : in out Test) is
      State : access Skill_State := new Skill_State;
   begin
      Skill.Read (State, "resources/annotationTest.sf");
      Skill.Write (State, File_Name);

      declare
         A : Date_Type_Access := New_Date (State, 3);
         B : Date_Type_Access := New_Date (State, 4);
      begin
         New_Test (State, Skill_Type_Access (A));
         New_Test (State, Skill_Type_Access (B));
      end;

      Skill.Append (State);
   end Set_Up;

   procedure Tear_Down (T : in out Test) is
   begin
      Ada.Directories.Delete_File (File_Name);
   end Tear_Down;

   procedure Append_Test_1 (T : in out Ahven.Framework.Test_Case'Class) is
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
   end Append_Test_1;

   procedure Append_Test_2 (T : in out Ahven.Framework.Test_Case'Class) is
      State : access Skill_State := new Skill_State;
   begin
      Skill.Read (State, File_Name);

      declare
         Test : Test_Type_Access := Skill.Get_Test (State, 2);
         Date : Date_Type_Access := Skill.Get_Date (State, 3);
         X : Date_Type_Access := Date_Type_Access (Test.Get_F);
         Y : Date_Type_Access := Date;
      begin
         Ahven.Assert (X = Y, "objects are not equal");
      end;
   end Append_Test_2;

   procedure Append_Test_3 (T : in out Ahven.Framework.Test_Case'Class) is
      State : access Skill_State := new Skill_State;
   begin
      Skill.Read (State, File_Name);

      declare
         Test : Test_Type_Access := Skill.Get_Test (State, 3);
         Date : Date_Type_Access := Skill.Get_Date (State, 4);
         X : Date_Type_Access := Date_Type_Access (Test.Get_F);
         Y : Date_Type_Access := Date;
      begin
         Ahven.Assert (X = Y, "objects are not equal");
      end;
   end Append_Test_3;

end Test_Annotation.Append;

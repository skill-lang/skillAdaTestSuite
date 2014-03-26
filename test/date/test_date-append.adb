package body Test_Date.Append is

   File_Name : constant String := "tmp/test-append-date.sf";

   procedure Initialize (T : in out Test) is
   begin
      Set_Name (T, "Test_Date.Append");
      Ahven.Framework.Add_Test_Routine (T, Read_Append_Read'Access, "read, append, read");
      Ahven.Framework.Add_Test_Routine (T, Create_Write_4xAppend_Read'Access, "create, write, 4x append, read");
   end Initialize;

   procedure Set_Up (T : in out Test) is
      State : access Skill_State := new Skill_State;
   begin
      Skill.Read (State, "resources/date-example.sf");
      Skill.Write (State, File_Name);
   end Set_Up;

   procedure Tear_Down (T : in out Test) is
   begin
      Ada.Directories.Delete_File (File_Name);
   end Tear_Down;

   procedure Read_Append_Read (T : in out Ahven.Framework.Test_Case'Class) is
   begin
      declare
         State : access Skill_State := new Skill_State;
      begin
         Skill.Read (State, File_Name);
         New_Date (State, 23);
         New_Date (State, 42);
         Skill.Append (State, File_Name);
      end;

      declare
         State : access Skill_State := new Skill_State;
      begin
         Read (State, File_Name);
         Ahven.Assert (Get_Date (State, 1).Get_Date = 1, "Get_Date is not 1.");
         Ahven.Assert (Get_Date (State, 2).Get_Date = -1, "Get_Date is not -1.");
         Ahven.Assert (Get_Date (State, 3).Get_Date = 23, "Get_Date is not 23.");
         Ahven.Assert (Get_Date (State, 4).Get_Date = 42, "Get_Date is not 42.");
      end;
   end Read_Append_Read;

   procedure Create_Write_4xAppend_Read (T : in out Ahven.Framework.Test_Case'Class) is
   begin
      declare
         State : access Skill_State := new Skill_State;
      begin
         Create (State);
         New_Date (State, 1);
         New_Date (State, 2);
         Write (State, File_Name);
         New_Date (State, 3);
         New_Date (State, 4);
         Skill.Append (State, File_Name);
         Skill.Append (State, File_Name);
         Skill.Append (State, File_Name);
         New_Date (State, 5);
         Skill.Append (State, File_Name);
      end;

      declare
         State : access Skill_State := new Skill_State;
      begin
         Skill.Read (State, File_Name);
         Ahven.Assert (Get_Date (State, 1).Get_Date = 1, "Get_Date is not 1.");
         Ahven.Assert (Get_Date (State, 2).Get_Date = 2, "Get_Date is not 2.");
         Ahven.Assert (Get_Date (State, 3).Get_Date = 3, "Get_Date is not 3.");
         Ahven.Assert (Get_Date (State, 4).Get_Date = 4, "Get_Date is not 4.");
         Ahven.Assert (Get_Date (State, 5).Get_Date = 5, "Get_Date is not 5.");
      end;
   end Create_Write_4xAppend_Read;

end Test_Date.Append;

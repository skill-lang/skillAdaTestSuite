package body Test_Aircraft.Write is
   File_Name : constant String := "tmp/test-write-aircraft.sf";

   procedure Initialize (T : in out Test) is
   begin
      Set_Name (T, "Test_Aircraft.Write");
      Ahven.Framework.Add_Test_Routine (T, Airplane_1'Access, "airplane 1: 1, Fokker 100, true");
      Ahven.Framework.Add_Test_Routine (T, Airplane_2'Access, "airplane 2: 2, Bombardier Dash 8, false");
      Ahven.Framework.Add_Test_Routine (T, Helicopter_1'Access, "helicopter 1: 1, Bell 206, false");
      Ahven.Framework.Add_Test_Routine (T, Helicopter_1'Access, "helicopter 2: 2, Sikorsky S-76C+, true");
   end Initialize;

   procedure Set_Up (T : in out Test) is
      State : access Skill_State := new Skill_State;
   begin
      Skill.Create (State);

      New_Airplane (State, new String'("Fokker 100"), True, 1);
      New_Airplane (State, new String'("Bombardier Dash 8"), False, 2);

      New_Helicopter (State, new String'("Bell 206"), False, 1);
      New_Helicopter (State, new String'("Sikorsky S-76C+"), True, 2);

      Skill.Write (State, File_Name);
   end Set_Up;

   procedure Tear_Down (T : in out Test) is
   begin
      Ada.Directories.Delete_File (File_Name);
   end Tear_Down;

   procedure Airplane_1 (T : in out Ahven.Framework.Test_Case'Class) is
      use Ada.Strings.Unbounded;

      State : access Skill_State := new Skill_State;
   begin
      Skill.Read (State, File_Name);

      declare
         X : Airplane_Type_Access := Skill.Get_Airplane (State, 1);
      begin
         Ahven.Assert (X.Get_Id = 1, "'first airplane'.Get_Id is not 1.");
         Ahven.Assert (X.Get_Name.all = "Fokker 100", "'first airplane'.Get_Name is not 'Fokker 100'.");
         Ahven.Assert (X.Get_Operational = True, "'first airplane'.Get_Operational is not true.");
      end;
   end Airplane_1;

   procedure Airplane_2 (T : in out Ahven.Framework.Test_Case'Class) is
      use Ada.Strings.Unbounded;

      State : access Skill_State := new Skill_State;
   begin
      Skill.Read (State, File_Name);

      declare
         X : Airplane_Type_Access := Skill.Get_Airplane (State, 2);
      begin
         Ahven.Assert (X.Get_Id = 2, "'second airplane'.Get_Id is not 2.");
         Ahven.Assert (X.Get_Name.all = "Bombardier Dash 8", "'second airplane'.Get_Name is not 'Bombardier Dash 8'.");
         Ahven.Assert (X.Get_Operational = False, "'second airplane'.Get_Operational is not false.");
      end;
   end Airplane_2;

   procedure Helicopter_1 (T : in out Ahven.Framework.Test_Case'Class) is
      use Ada.Strings.Unbounded;

      State : access Skill_State := new Skill_State;
   begin
      Skill.Read (State, File_Name);

      declare
         X : Helicopter_Type_Access := Skill.Get_Helicopter (State, 1);
      begin
         Ahven.Assert (X.Get_Id = 1, "'first helicopter'.Get_Id is not 1.");
         Ahven.Assert (X.Get_Name.all = "Bell 206", "'first helicopter'.Get_Name is not 'Bell 206'.");
         Ahven.Assert (X.Get_Operational = False, "'first helicopter'.Get_Operational is not false.");
      end;
   end Helicopter_1;

   procedure Helicopter_2 (T : in out Ahven.Framework.Test_Case'Class) is
      use Ada.Strings.Unbounded;

      State : access Skill_State := new Skill_State;
   begin
      Skill.Read (State, File_Name);

      declare
         X : Helicopter_Type_Access := Skill.Get_Helicopter (State, 2);
      begin
         Ahven.Assert (X.Get_Id = 2, "'first helicopter'.Get_Id is not 2.");
         Ahven.Assert (X.Get_Name.all = "Sikorsky S-76C+", "'first helicopter'.Get_Name is not 'Sikorsky S-76C+'.");
         Ahven.Assert (X.Get_Operational = True, "'first helicopter'.Get_Operational is not true.");
      end;
   end Helicopter_2;

end Test_Aircraft.Write;

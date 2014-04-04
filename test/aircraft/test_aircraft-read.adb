package body Test_Aircraft.Read is

   package Skill renames Aircraft.Api;

   procedure Initialize (T : in out Test) is
   begin
      Set_Name (T, "Test_Aircraft.Read");
      Ahven.Framework.Add_Test_Routine (T, Airplane_1'Access, "airplane 1: 1, Fokker 100, true");
      Ahven.Framework.Add_Test_Routine (T, Airplane_2'Access, "airplane 2: 2, Bombardier Dash 8, false");
      Ahven.Framework.Add_Test_Routine (T, Helicopter_1'Access, "helicopter 1: 1, Bell 206, false");
      Ahven.Framework.Add_Test_Routine (T, Helicopter_1'Access, "helicopter 2: 2, Sikorsky S-76C+, true");
   end Initialize;

   procedure Airplane_1 is
      use Ada.Strings.Unbounded;

      State : access Skill_State := new Skill_State;
   begin
      Skill.Read (State, "resources/aircraft.sf");

      declare
         X : Airplane_Type_Access := Skill.Get_Airplane (State, 1);
      begin
         Ahven.Assert (X.Get_Id = 1, "'first airplane'.Get_Id is not 1.");
         Ahven.Assert (X.Get_Name.all = "Fokker 100", "'first airplane'.Get_Name is not 'Fokker 100'.");
         Ahven.Assert (X.Get_Operational = True, "'first airplane'.Get_Operational is not true.");
      end;
   end Airplane_1;

   procedure Airplane_2 is
      use Ada.Strings.Unbounded;

      State : access Skill_State := new Skill_State;
   begin
      Skill.Read (State, "resources/aircraft.sf");

      declare
         X : Airplane_Type_Access := Skill.Get_Airplane (State, 2);
      begin
         Ahven.Assert (X.Get_Id = 2, "'second airplane'.Get_Id is not 2.");
         Ahven.Assert (X.Get_Name.all = "Bombardier Dash 8", "'second airplane'.Get_Name is not 'Bombardier Dash 8'.");
         Ahven.Assert (X.Get_Operational = False, "'second airplane'.Get_Operational is not false.");
      end;
   end Airplane_2;

   procedure Helicopter_1 is
      use Ada.Strings.Unbounded;

      State : access Skill_State := new Skill_State;
   begin
      Skill.Read (State, "resources/aircraft.sf");

      declare
         X : Helicopter_Type_Access := Skill.Get_Helicopter (State, 1);
      begin
         Ahven.Assert (X.Get_Id = 1, "'first helicopter'.Get_Id is not 1.");
         Ahven.Assert (X.Get_Name.all = "Bell 206", "'first helicopter'.Get_Name is not 'Bell 206'.");
         Ahven.Assert (X.Get_Operational = False, "'first helicopter'.Get_Operational is not false.");
      end;
   end Helicopter_1;

   procedure Helicopter_2 is
      use Ada.Strings.Unbounded;

      State : access Skill_State := new Skill_State;
   begin
      Skill.Read (State, "resources/aircraft.sf");

      declare
         X : Helicopter_Type_Access := Skill.Get_Helicopter (State, 2);
      begin
         Ahven.Assert (X.Get_Id = 2, "'first helicopter'.Get_Id is not 2.");
         Ahven.Assert (X.Get_Name.all = "Sikorsky S-76C+", "'first helicopter'.Get_Name is not 'Sikorsky S-76C+'.");
         Ahven.Assert (X.Get_Operational = True, "'first helicopter'.Get_Operational is not true.");
      end;
   end Helicopter_2;

end Test_Aircraft.Read;

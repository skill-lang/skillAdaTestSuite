package body Aircraft.Test.Parse is

   package Skill renames Aircraft.Api.Skill;
   use Aircraft;
   use Skill;

   procedure Initialize (T : in out Test) is
   begin
      Set_Name (T, "Aircraft.Test.Parse");
      Ahven.Framework.Add_Test_Routine (T, Airplane_1'Access, "airplane 1: 1, Fokker 100, true");
      Ahven.Framework.Add_Test_Routine (T, Airplane_2'Access, "airplane 2: 2, Bombardier Dash 8, false");
      Ahven.Framework.Add_Test_Routine (T, Helicopter_1'Access, "helicopter 1: 1, Bell 206, false");
      Ahven.Framework.Add_Test_Routine (T, Helicopter_1'Access, "helicopter 2: 2, Sikorsky S-76C+, true");

      Skill.Read (T.State, "resources/aircraft.sf");
   end Initialize;

   procedure Airplane_1 (T : in out Ahven.Framework.Test_Case'Class) is
      use Ada.Strings.Unbounded;

      X : Airplane_Instances := Skill.Get_Airplanes (Test (T).State);
   begin
      Ahven.Assert (X (1).x = 42, "'first airplane'.x is not 42.");
      Ahven.Assert (X (1).id = 1, "'first airplane'.id is not 1.");
      Ahven.Assert (X (1).name = "Fokker 100", "'first airplane'.name is not 'Fokker 100'.");
      Ahven.Assert (X (1).operational = True, "'first airplane'.operational is not true.");
   end Airplane_1;

   procedure Airplane_2 (T : in out Ahven.Framework.Test_Case'Class) is
      use Ada.Strings.Unbounded;

      X : Airplane_Instances := Skill.Get_Airplanes (Test (T).State);
   begin
      Ahven.Assert (X (2).x = 42, "'second airplane'.x is not 42.");
      Ahven.Assert (X (2).id = 2, "'second airplane'.id is not 2.");
      Ahven.Assert (X (2).name = "Bombardier Dash 8", "'second airplane'.name is not 'Bombardier Dash 8'.");
      Ahven.Assert (X (2).operational = False, "'second airplane'.operational is not false.");
   end Airplane_2;

   procedure Helicopter_1 (T : in out Ahven.Framework.Test_Case'Class) is
      use Ada.Strings.Unbounded;

      X : Helicopter_Instances := Skill.Get_Helicopters (Test (T).State);
   begin
      Ahven.Assert (X (1).id = 1, "'first helicopter'.id is not 1.");
      Ahven.Assert (X (1).name = "Bell 206", "'first helicopter'.name is not 'Bell 206'.");
      Ahven.Assert (X (1).operational = False, "'first helicopter'.operational is not false.");
   end Helicopter_1;

   procedure Helicopter_2 (T : in out Ahven.Framework.Test_Case'Class) is
      use Ada.Strings.Unbounded;

      X : Helicopter_Instances := Skill.Get_Helicopters (Test (T).State);
   begin
      Ahven.Assert (X (2).id = 2, "'first helicopter'.id is not 2.");
      Ahven.Assert (X (2).name = "Sikorsky S-76C+", "'first helicopter'.name is not 'Sikorsky S-76C+'.");
      Ahven.Assert (X (2).operational = True, "'first helicopter'.operational is not true.");
   end Helicopter_2;

end Aircraft.Test.Parse;

with Ada.Directories;
with Ada.Strings.Unbounded;
with Ahven.Framework;
with Aircraft.Api;

package Test_Aircraft.Write is

   package Skill renames Aircraft.Api;
   use Aircraft;
   use Aircraft.Api;

   type Test is new Ahven.Framework.Test_Case with null record;

   procedure Initialize (T : in out Test);

   procedure Set_Up (T : in out Test);
   procedure Tear_Down (T : in out Test);

   procedure Airplane_1 (T : in out Ahven.Framework.Test_Case'Class);
   procedure Airplane_2 (T : in out Ahven.Framework.Test_Case'Class);

   procedure Helicopter_1 (T : in out Ahven.Framework.Test_Case'Class);
   procedure Helicopter_2 (T : in out Ahven.Framework.Test_Case'Class);

end Test_Aircraft.Write;

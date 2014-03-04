with Ada.Strings.Unbounded;
with Ahven.Framework;
with Aircraft.Api.Skill;

package Test_Aircraft.Parse is

   package Skill renames Aircraft.Api.Skill;
   use Aircraft;
   use Skill;

   type Test is new Ahven.Framework.Test_Case with record
      State : access Skill_State := new Skill_State;
   end record;

   procedure Initialize (T : in out Test);

   procedure Airplane_1 (T : in out Ahven.Framework.Test_Case'Class);
   procedure Airplane_2 (T : in out Ahven.Framework.Test_Case'Class);

   procedure Helicopter_1 (T : in out Ahven.Framework.Test_Case'Class);
   procedure Helicopter_2 (T : in out Ahven.Framework.Test_Case'Class);

end Test_Aircraft.Parse;

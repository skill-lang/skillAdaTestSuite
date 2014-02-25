with Ahven.Framework;
with Aircraft;
with Aircraft.Api.Skill;

package Aircraft.Test.Parse is

   type Test is new Ahven.Framework.Test_Case with record
      State : access Skill_State := new Skill_State;
   end record;

   procedure Initialize (T : in out Test);

   procedure Airplane_1 (T : in out Ahven.Framework.Test_Case'Class);
   procedure Airplane_2 (T : in out Ahven.Framework.Test_Case'Class);

   procedure Helicopter_1 (T : in out Ahven.Framework.Test_Case'Class);
   procedure Helicopter_2 (T : in out Ahven.Framework.Test_Case'Class);

end Aircraft.Test.Parse;

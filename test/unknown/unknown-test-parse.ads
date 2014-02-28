with Ada.Characters.Handling;
with Ada.Strings.Fixed;
with Ada.Tags;
with Ahven.Framework;
with Unknown;
with Unknown.Api.Skill;

package Unknown.Test.Parse is

   type Test is new Ahven.Framework.Test_Case with record
      State : access Skill_State := new Skill_State;
   end record;

   procedure Initialize (T : in out Test);

   procedure Check_Types (T : in out Ahven.Framework.Test_Case'Class);

   procedure Check_Fields_A (T : in out Ahven.Framework.Test_Case'Class);
   procedure Check_Fields_C (T : in out Ahven.Framework.Test_Case'Class);

end Unknown.Test.Parse;

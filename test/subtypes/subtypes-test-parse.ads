with Ada.Characters.Handling;
with Ada.Strings.Fixed;
with Ada.Tags;
with Ahven.Framework;
with Subtypes;
with Subtypes.Api.Skill;

package Subtypes.Test.Parse is

   type Test is new Ahven.Framework.Test_Case with record
      State : access Skill_State := new Skill_State;
   end record;

   procedure Initialize (T : in out Test);

   procedure Check_Types (T : in out Ahven.Framework.Test_Case'Class);

   procedure Check_Fields_A (T : in out Ahven.Framework.Test_Case'Class);
   procedure Check_Fields_B (T : in out Ahven.Framework.Test_Case'Class);
   procedure Check_Fields_C (T : in out Ahven.Framework.Test_Case'Class);
   procedure Check_Fields_D (T : in out Ahven.Framework.Test_Case'Class);

end Subtypes.Test.Parse;

with Ahven.Framework;
with Date;
with Date.Api.Skill;

package Date.Test.Parse is

   type Test is new Ahven.Framework.Test_Case with record
      State : access Skill_State := new Skill_State;
   end record;

   procedure Initialize (T : in out Test);

   procedure Date_1 (T : in out Ahven.Framework.Test_Case'Class);
   procedure Date_2 (T : in out Ahven.Framework.Test_Case'Class);

end Date.Test.Parse;

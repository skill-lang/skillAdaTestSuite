with Ahven.Framework;
with Date;
with Date.Api.Skill;

package Date.Test.Parse_Test is

   type Test is new Ahven.Framework.Test_Case with record
      State : access Skill_State := new Skill_State;
   end record;

   procedure Initialize (T : in out Test);

   procedure First_Date (T : in out Ahven.Framework.Test_Case'Class);
   procedure Second_Date (T : in out Ahven.Framework.Test_Case'Class);

end Date.Test.Parse_Test;

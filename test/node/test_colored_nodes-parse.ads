with Ahven.Framework;
with Node.Api.Skill;

package Test_Colored_Nodes.Parse is

   package Skill renames Node.Api.Skill;
   use Node;
   use Skill;

   type Test is new Ahven.Framework.Test_Case with record
      State : access Skill_State := new Skill_State;
   end record;

   procedure Initialize (T : in out Test);

   procedure Node_1 (T : in out Ahven.Framework.Test_Case'Class);
   procedure Node_2 (T : in out Ahven.Framework.Test_Case'Class);

end Test_Colored_Nodes.Parse;

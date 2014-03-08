with Ahven.Framework;
with Node.Api.Skill;

package Test_Node.Read is

   package Skill renames Node.Api.Skill;
   use Node;
   use Skill;

   type Test is new Ahven.Framework.Test_Case with record
      State : access Skill_State := new Skill_State;
   end record;

   procedure Initialize (T : in out Test);

   procedure Node_1;
   procedure Node_2;
   procedure Node_3;
   procedure Node_4;

end Test_Node.Read;

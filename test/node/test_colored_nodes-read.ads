with Ahven.Framework;
with Node.Api;

package Test_Colored_Nodes.Read is

   package Skill renames Node.Api;
   use Node;
   use Node.Api;

   type Test is new Ahven.Framework.Test_Case with record
      State : access Skill_State := new Skill_State;
   end record;

   procedure Initialize (T : in out Test);

   procedure Node_1;
   procedure Node_2;

end Test_Colored_Nodes.Read;

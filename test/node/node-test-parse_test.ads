with Ahven.Framework;
with Node;
with Node.Api.Skill;

package Node.Test.Parse_Test is

   type Test is new Ahven.Framework.Test_Case with record
      State : access Skill_State := new Skill_State;
   end record;

   procedure Initialize (T : in out Test);

   procedure First_Node (T : in out Ahven.Framework.Test_Case'Class);
   procedure Second_Node (T : in out Ahven.Framework.Test_Case'Class);
   procedure Third_Node (T : in out Ahven.Framework.Test_Case'Class);
   procedure Fourth_Node (T : in out Ahven.Framework.Test_Case'Class);

end Node.Test.Parse_Test;

with Ahven.Framework;
with Container.Api.Skill;

package Test_Container.Read is

   package Skill renames Container.Api.Skill;
   use Container;
   use Skill;

   type Test is new Ahven.Framework.Test_Case with null record;

   procedure Initialize (T : in out Test);

   procedure Constant_Length_Array;
   procedure Variable_Length_Array;
   procedure List;
   procedure Set;

end Test_Container.Read;

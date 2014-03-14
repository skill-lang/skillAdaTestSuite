with Ada.Directories;
with Ahven.Framework;
with Container.Api.Skill;

with Ada.Text_IO;

package Test_Container.Write is

   package Skill renames Container.Api.Skill;
   use Container;
   use Skill;

   type Test is new Ahven.Framework.Test_Case with null record;

   procedure Initialize (T : in out Test);

   procedure Set_Up (T : in out Test);
   procedure Tear_Down (T : in out Test);

   procedure Constant_Length_Array (T : in out Ahven.Framework.Test_Case'Class);
   procedure Variable_Length_Array (T : in out Ahven.Framework.Test_Case'Class);
   procedure List (T : in out Ahven.Framework.Test_Case'Class);
   procedure Set (T : in out Ahven.Framework.Test_Case'Class);
   procedure Map (T : in out Ahven.Framework.Test_Case'Class);

end Test_Container.Write;

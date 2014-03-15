with Ada.Directories;
with Ahven.Framework;
with Constants.Api.Skill;

with Ada.Text_IO;

package Test_Constants.Write is

   package Skill renames Constants.Api.Skill;
   use Constants;
   use Skill;

   type Test is new Ahven.Framework.Test_Case with null record;

   procedure Initialize (T : in out Test);

   procedure Set_Up (T : in out Test);
   procedure Tear_Down (T : in out Test);

   procedure A (T : in out Ahven.Framework.Test_Case'Class);
   procedure B (T : in out Ahven.Framework.Test_Case'Class);
   procedure C (T : in out Ahven.Framework.Test_Case'Class);
   procedure D (T : in out Ahven.Framework.Test_Case'Class);
   procedure E (T : in out Ahven.Framework.Test_Case'Class);

end Test_Constants.Write;

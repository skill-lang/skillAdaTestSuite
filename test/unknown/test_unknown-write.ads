with Ada.Characters.Handling;
with Ada.Directories;
with Ada.Strings.Fixed;
with Ada.Tags;
with Ahven.Framework;
with Unknown.Api.Skill;

package Test_Unknown.Write is

   package Skill renames Unknown.Api.Skill;
   use Unknown;
   use Skill;

   type Test is new Ahven.Framework.Test_Case with null record;

   procedure Initialize (T : in out Test);

   procedure Set_Up (T : in out Test);
   procedure Tear_Down (T : in out Test);

   procedure Check_Types (T : in out Ahven.Framework.Test_Case'Class);

   procedure Check_Fields_A (T : in out Ahven.Framework.Test_Case'Class);
   procedure Check_Fields_C (T : in out Ahven.Framework.Test_Case'Class);

end Test_Unknown.Write;

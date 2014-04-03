with Ada.Characters.Handling;
with Ada.Directories;
with Ada.Strings.Fixed;
with Ada.Tags;
with Ahven.Framework;
with Subtypes.Api;

package Test_Subtypes.Write is

   package Skill renames Subtypes.Api;
   use Subtypes;
   use Subtypes.Api;

   type Test is new Ahven.Framework.Test_Case with null record;

   procedure Initialize (T : in out Test);

   procedure Set_Up (T : in out Test);
   procedure Tear_Down (T : in out Test);

   procedure Check_Types (T : in out Ahven.Framework.Test_Case'Class);

   procedure Check_Fields_A (T : in out Ahven.Framework.Test_Case'Class);
   procedure Check_Fields_B (T : in out Ahven.Framework.Test_Case'Class);
   procedure Check_Fields_C (T : in out Ahven.Framework.Test_Case'Class);
   procedure Check_Fields_D (T : in out Ahven.Framework.Test_Case'Class);

end Test_Subtypes.Write;

with Ada.Characters.Handling;
with Ada.Strings.Fixed;
with Ada.Tags;
with Ahven.Framework;
with Unknown.Api.Skill;

package Test_Unknown.Read is

   package Skill renames Unknown.Api.Skill;
   use Unknown;
   use Skill;

   type Test is new Ahven.Framework.Test_Case with null record;

   procedure Initialize (T : in out Test);

   procedure Check_Types;

   procedure Check_Fields_A;
   procedure Check_Fields_C;

end Test_Unknown.Read;

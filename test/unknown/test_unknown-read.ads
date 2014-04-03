with Ada.Characters.Handling;
with Ada.Strings.Fixed;
with Ada.Tags;
with Ahven.Framework;
with Unknown.Api;

package Test_Unknown.Read is

   package Skill renames Unknown.Api;
   use Unknown;
   use Unknown.Api;

   type Test is new Ahven.Framework.Test_Case with null record;

   procedure Initialize (T : in out Test);

   procedure Check_Types;

   procedure Check_Fields_A;
   procedure Check_Fields_C;

end Test_Unknown.Read;

with Ada.Characters.Handling;
with Ada.Strings.Fixed;
with Ada.Tags;
with Ahven.Framework;
with Subtypes.Api;

package Test_Subtypes.Read is

   package Skill renames Subtypes.Api;
   use Subtypes;
   use Subtypes.Api;

   type Test is new Ahven.Framework.Test_Case with null record;

   procedure Initialize (T : in out Test);

   procedure Check_Types;

   procedure Check_Fields_A;
   procedure Check_Fields_B;
   procedure Check_Fields_C;
   procedure Check_Fields_D;

end Test_Subtypes.Read;

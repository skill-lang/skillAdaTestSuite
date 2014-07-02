with Ada.Directories;
with Ada.Numerics.Generic_Elementary_Functions;
with Ahven.Framework;
with Floats.Api;

package Test_Floats.Write is

   package Skill renames Floats.Api;
   use Floats;
   use Floats.Api;

   type Test is new Ahven.Framework.Test_Case with null record;

   procedure Initialize (T : in out Test);

   procedure Set_Up (T : in out Test);
   procedure Tear_Down (T : in out Test);

   procedure Float (T : in out Ahven.Framework.Test_Case'Class);
   procedure Double (T : in out Ahven.Framework.Test_Case'Class);

end Test_Floats.Write;

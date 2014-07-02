with Ada.Numerics.Generic_Elementary_Functions;
with Ahven.Framework;
with Floats.Api;

package Test_Floats.Read is

   use Floats;
   use Floats.Api;

   type Test is new Ahven.Framework.Test_Case with null record;

   procedure Initialize (T : in out Test);

   procedure Float;
   procedure Double;

end Test_Floats.Read;

with Ada.Strings.Unbounded;
with Ahven.Framework;
with Aircraft.Api;

package Test_Aircraft.Read is

   use Aircraft;
   use Aircraft.Api;

   type Test is new Ahven.Framework.Test_Case with null record;

   procedure Initialize (T : in out Test);

   procedure Airplane_1;
   procedure Airplane_2;

   procedure Helicopter_1;
   procedure Helicopter_2;

end Test_Aircraft.Read;

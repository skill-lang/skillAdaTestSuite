with Ahven.Framework;
with Date.Api;

package Test_Date.Read is

   package Skill renames Date.Api;
   use Date;
   use Date.Api;

   type Test is new Ahven.Framework.Test_Case with null record;

   procedure Initialize (T : in out Test);

   procedure Date_1;
   procedure Date_2;

end Test_Date.Read;

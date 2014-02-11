with Ahven.Framework;

package Tests is

   type Test is new Ahven.Framework.Test_Case with null record;

   procedure Initialize (T : in out Test);

   procedure Test_Test;

end Tests;

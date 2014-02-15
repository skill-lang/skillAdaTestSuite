with Ahven.Framework;

package Date.Test.Byte_Checker_Boolean is
   type Test is new Ahven.Framework.Test_Case with null record;

   procedure Initialize (T : in out Test);

   function Write_Read (Value : Boolean) return Boolean;

   procedure True;
   procedure False;

end Date.Test.Byte_Checker_Boolean;

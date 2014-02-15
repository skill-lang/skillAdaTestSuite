with Ahven.Framework;

package Date.Test.Byte_Checker_String is
   type Test is new Ahven.Framework.Test_Case with null record;

   procedure Initialize (T : in out Test);

   function Write_Read (Value : String) return String;

   procedure String_1;

end Date.Test.Byte_Checker_String;

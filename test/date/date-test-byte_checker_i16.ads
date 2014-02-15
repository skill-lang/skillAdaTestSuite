with Ahven.Framework;

package Date.Test.Byte_Checker_i16 is
   type Test is new Ahven.Framework.Test_Case with null record;

   procedure Initialize (T : in out Test);

   function Write_Read (Value : i16) return i16;

   procedure First;
   procedure Minus_One;
   procedure Zero;
   procedure Plus_One;
   procedure Last;

end Date.Test.Byte_Checker_i16;

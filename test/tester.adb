with Ahven.Framework;
with Ahven.Text_Runner;

with Date.Test.Byte_Checker.i8;
with Date.Test.Byte_Checker.i16;
with Date.Test.Byte_Checker.i32;
with Date.Test.Byte_Checker.i64;
with Date.Test.Byte_Checker.v64;

with Date.Test.Parse_Test;

procedure Tester is
   Suite : Ahven.Framework.Test_Suite := Ahven.Framework.Create_Suite ("All");
begin
   Ahven.Framework.Add_Test (Suite, new Date.Test.Byte_Checker.i8.Test);
   Ahven.Framework.Add_Test (Suite, new Date.Test.Byte_Checker.i16.Test);
   Ahven.Framework.Add_Test (Suite, new Date.Test.Byte_Checker.i32.Test);
   Ahven.Framework.Add_Test (Suite, new Date.Test.Byte_Checker.i64.Test);
   Ahven.Framework.Add_Test (Suite, new Date.Test.Byte_Checker.v64.Test);

   Ahven.Framework.Add_Test (Suite, new Date.Test.Parse_Test.Test);
   Ahven.Text_Runner.Run (Suite);
end Tester;

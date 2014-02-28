with Ahven.Framework;
with Ahven.Text_Runner;

with Aircraft.Test.Parse;

with Annotation.Test.Parse;

with Date.Test.Byte_Checker_i8;
with Date.Test.Byte_Checker_i16;
with Date.Test.Byte_Checker_i32;
with Date.Test.Byte_Checker_i64;
with Date.Test.Byte_Checker_v64;
with Date.Test.Byte_Checker_Boolean;
with Date.Test.Byte_Checker_String;
with Date.Test.Parse;

with Node.Test.Parse;

with Subtypes.Test.Parse;

with Unknown.Test.Parse;

procedure Tester is
   Suite : Ahven.Framework.Test_Suite := Ahven.Framework.Create_Suite ("All");
begin
   Ahven.Framework.Add_Test (Suite, new Aircraft.Test.Parse.Test);

   Ahven.Framework.Add_Test (Suite, new Annotation.Test.Parse.Test);

   Ahven.Framework.Add_Test (Suite, new Date.Test.Byte_Checker_i8.Test);
   Ahven.Framework.Add_Test (Suite, new Date.Test.Byte_Checker_i16.Test);
   Ahven.Framework.Add_Test (Suite, new Date.Test.Byte_Checker_i32.Test);
   Ahven.Framework.Add_Test (Suite, new Date.Test.Byte_Checker_i64.Test);
   Ahven.Framework.Add_Test (Suite, new Date.Test.Byte_Checker_v64.Test);
   Ahven.Framework.Add_Test (Suite, new Date.Test.Byte_Checker_Boolean.Test);
   Ahven.Framework.Add_Test (Suite, new Date.Test.Byte_Checker_String.Test);
   Ahven.Framework.Add_Test (Suite, new Date.Test.Parse.Test);

   Ahven.Framework.Add_Test (Suite, new Node.Test.Parse.Test);

   Ahven.Framework.Add_Test (Suite, new Subtypes.Test.Parse.Test);

   Ahven.Framework.Add_Test (Suite, new Unknown.Test.Parse.Test);

   Ahven.Text_Runner.Run (Suite);
end Tester;

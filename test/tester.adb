with Ahven.Framework;
with Ahven.Text_Runner;

with Date.Test.Parse_Test;

procedure Tester is
   Suite : Ahven.Framework.Test_Suite := Ahven.Framework.Create_Suite ("All");
begin
   Ahven.Framework.Add_Test (Suite, new Date.Test.Parse_Test.Test);
   Ahven.Text_Runner.Run (Suite);
end Tester;

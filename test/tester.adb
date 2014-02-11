with Ahven.Text_Runner;
with Ahven.Framework;

with Tests;

procedure Tester is
   Suite : Ahven.Framework.Test_Suite := Ahven.Framework.Create_Suite ("All");
begin
   Ahven.Framework.Add_Test (Suite, new Tests.Test);
   Ahven.Text_Runner.Run (Suite);
end Tester;

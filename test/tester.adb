with Ahven.Framework;
with Ahven.Text_Runner;

with Test_Aircraft.Parse;
with Test_Annotation.Parse;
with Test_Colored_Nodes.Parse;
with Test_Date.Parse;
with Test_Foreign.Parse;
with Test_Node.Parse;
with Test_Subtypes.Parse;
with Test_Unknown.Parse;

procedure Tester is
   Suite : Ahven.Framework.Test_Suite := Ahven.Framework.Create_Suite ("All");
begin
   Ahven.Framework.Add_Test (Suite, new Test_Aircraft.Parse.Test);
   Ahven.Framework.Add_Test (Suite, new Test_Annotation.Parse.Test);
   Ahven.Framework.Add_Test (Suite, new Test_Colored_Nodes.Parse.Test);
   Ahven.Framework.Add_Test (Suite, new Test_Date.Parse.Test);
   Ahven.Framework.Add_Test (Suite, new Test_Foreign.Parse.Test);
   Ahven.Framework.Add_Test (Suite, new Test_Node.Parse.Test);
   Ahven.Framework.Add_Test (Suite, new Test_Subtypes.Parse.Test);
   Ahven.Framework.Add_Test (Suite, new Test_Unknown.Parse.Test);

   Ahven.Text_Runner.Run (Suite);
end Tester;

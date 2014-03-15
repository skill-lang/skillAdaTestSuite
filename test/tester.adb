with Ahven.Framework;
with Ahven.Text_Runner;

with Test_Aircraft.Read;
with Test_Annotation.Read;
with Test_Annotation.Write;
with Test_Colored_Nodes.Read;
with Test_Constants.Write;
with Test_Container.Read;
with Test_Container.Write;
with Test_Date.Read;
with Test_Foreign.Read;
with Test_Node.Read;
with Test_Subtypes.Read;
with Test_Unknown.Read;

procedure Tester is
   Suite : Ahven.Framework.Test_Suite := Ahven.Framework.Create_Suite ("All");
begin
   Ahven.Framework.Add_Test (Suite, new Test_Aircraft.Read.Test);
   Ahven.Framework.Add_Test (Suite, new Test_Annotation.Read.Test);
   Ahven.Framework.Add_Test (Suite, new Test_Annotation.Write.Test);
   Ahven.Framework.Add_Test (Suite, new Test_Colored_Nodes.Read.Test);
   Ahven.Framework.Add_Test (Suite, new Test_Constants.Write.Test);
   Ahven.Framework.Add_Test (Suite, new Test_Container.Read.Test);
   Ahven.Framework.Add_Test (Suite, new Test_Container.Write.Test);
   Ahven.Framework.Add_Test (Suite, new Test_Date.Read.Test);
   Ahven.Framework.Add_Test (Suite, new Test_Foreign.Read.Test);
   Ahven.Framework.Add_Test (Suite, new Test_Node.Read.Test);
   Ahven.Framework.Add_Test (Suite, new Test_Subtypes.Read.Test);
   Ahven.Framework.Add_Test (Suite, new Test_Unknown.Read.Test);

   Ahven.Text_Runner.Run (Suite);
end Tester;

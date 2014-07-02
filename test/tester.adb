with Ahven.Framework;
with Ahven.Text_Runner;

with Test_Aircraft.Append;
with Test_Aircraft.Read;
with Test_Aircraft.Write;

with Test_Annotation.Append;
with Test_Annotation.Read;
with Test_Annotation.Write;

with Test_Null_Annotation.Read;
with Test_Null_Annotation.Write;

with Test_Constants.Write;
with Test_Container.Read;
with Test_Container.Write;

with Test_Date.Append;
with Test_Date.Read;

with Test_Floats.Read;
with Test_Floats.Write;

with Test_Foreign.Read;

with Test_Colored_Nodes.Read;
with Test_Node.Read;

with Test_Subtypes.Append;
with Test_Subtypes.Read;
with Test_Subtypes.Write;

with Test_Unknown.Read;
with Test_Unknown.Write;

procedure Tester is
   Suite : Ahven.Framework.Test_Suite := Ahven.Framework.Create_Suite ("All");
begin
   Ahven.Framework.Add_Test (Suite, new Test_Aircraft.Append.Test);
   Ahven.Framework.Add_Test (Suite, new Test_Aircraft.Read.Test);
   Ahven.Framework.Add_Test (Suite, new Test_Aircraft.Write.Test);

   Ahven.Framework.Add_Test (Suite, new Test_Annotation.Append.Test);
   Ahven.Framework.Add_Test (Suite, new Test_Annotation.Read.Test);
   Ahven.Framework.Add_Test (Suite, new Test_Annotation.Write.Test);

   Ahven.Framework.Add_Test (Suite, new Test_Null_Annotation.Read.Test);
   Ahven.Framework.Add_Test (Suite, new Test_Null_Annotation.Write.Test);

   Ahven.Framework.Add_Test (Suite, new Test_Constants.Write.Test);
   Ahven.Framework.Add_Test (Suite, new Test_Container.Read.Test);
   Ahven.Framework.Add_Test (Suite, new Test_Container.Write.Test);

   Ahven.Framework.Add_Test (Suite, new Test_Date.Append.Test);
   Ahven.Framework.Add_Test (Suite, new Test_Date.Read.Test);

   Ahven.Framework.Add_Test (Suite, new Test_Floats.Read.Test);
   Ahven.Framework.Add_Test (Suite, new Test_Floats.Write.Test);

   Ahven.Framework.Add_Test (Suite, new Test_Foreign.Read.Test);

   Ahven.Framework.Add_Test (Suite, new Test_Colored_Nodes.Read.Test);
   Ahven.Framework.Add_Test (Suite, new Test_Node.Read.Test);

   Ahven.Framework.Add_Test (Suite, new Test_Subtypes.Append.Test);
   Ahven.Framework.Add_Test (Suite, new Test_Subtypes.Read.Test);
   Ahven.Framework.Add_Test (Suite, new Test_Subtypes.Write.Test);

   Ahven.Framework.Add_Test (Suite, new Test_Unknown.Read.Test);
   Ahven.Framework.Add_Test (Suite, new Test_Unknown.Write.Test);

   Ahven.Text_Runner.Run (Suite);
end Tester;

package body Date.Test.Parse_Test is

   package Skill renames Date.Api.Skill;
   use Date;
   use Skill;

   procedure Initialize (T : in out Test) is
   begin
      Set_Name (T, "Date.Test.Parse_Test");
      Ahven.Framework.Add_Test_Routine (T, First_Date'Access, "first date");
      Ahven.Framework.Add_Test_Routine (T, Second_Date'Access, "second date");

      Skill.Read (T.State, "resources/date-example.sf");
   end Initialize;

   procedure First_Date (T : in out Ahven.Framework.Test_Case'Class) is
      X : Date_Instances := Skill.Get_Dates (Test (T).State);
   begin
      Ahven.Assert (X (1).date = 1, "Date is not 1.");
   end First_Date;

   procedure Second_Date (T : in out Ahven.Framework.Test_Case'Class) is
      X : Date_Instances := Skill.Get_Dates (Test (T).State);
   begin
      Ahven.Assert (X (2).date = -1, "Date is not -1.");
   end Second_Date;

end Date.Test.Parse_Test;

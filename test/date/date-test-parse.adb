package body Date.Test.Parse is

   package Skill renames Date.Api.Skill;
   use Date;
   use Skill;

   procedure Initialize (T : in out Test) is
   begin
      Set_Name (T, "Date.Test.Parse");
      Ahven.Framework.Add_Test_Routine (T, Date_1'Access, "1. date: date = 1");
      Ahven.Framework.Add_Test_Routine (T, Date_2'Access, "2. date: date = -1");

      Skill.Read (T.State, "resources/date-example.sf");
   end Initialize;

   procedure Date_1 (T : in out Ahven.Framework.Test_Case'Class) is
      X : Date_Instances := Skill.Get_Dates (Test (T).State);
   begin
      Ahven.Assert (X (1).date = 1, "'first date'.date is not 1.");
   end Date_1;

   procedure Date_2 (T : in out Ahven.Framework.Test_Case'Class) is
      X : Date_Instances := Skill.Get_Dates (Test (T).State);
   begin
      Ahven.Assert (X (2).date = -1, "'second date'.date is not -1.");
   end Date_2;

end Date.Test.Parse;

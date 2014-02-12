package body Date.Test.Parse_Test is

   procedure Initialize (T : in out Test) is
   begin
      Set_Name (T, "Date.Test.Parse_Test");
      Ahven.Framework.Add_Test_Routine (T, Two_Dates'Access, "two dates");
   end Initialize;

   procedure Two_Dates is
      Date : Date_Type := (Date => 1);
   begin
      Ahven.Assert (Date.Date = 1, "Date is not 1.");
   end Two_Dates;

end Date.Test.Parse_Test;

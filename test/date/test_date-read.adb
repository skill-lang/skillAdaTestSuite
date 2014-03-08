package body Test_Date.Read is

   procedure Initialize (T : in out Test) is
   begin
      Set_Name (T, "Test_Date.Read");
      Ahven.Framework.Add_Test_Routine (T, Date_1'Access, "1. date: date = 1");
      Ahven.Framework.Add_Test_Routine (T, Date_2'Access, "2. date: date = -1");
   end Initialize;

   procedure Date_1 is
      State : access Skill_State := new Skill_State;
   begin
      Skill.Read (State, "resources/date-example.sf");

      declare
         X : Date_Type_Accesses := Skill.Get_Dates (State);
      begin
         Ahven.Assert (X (1).Get_Date = 1, "'first date'.Get_Date is not 1.");
      end;
   end Date_1;

   procedure Date_2 is
      State : access Skill_State := new Skill_State;
   begin
      Skill.Read (State, "resources/date-example.sf");

      declare
         X : Date_Type_Accesses := Skill.Get_Dates (State);
      begin
         Ahven.Assert (X (2).Get_Date = -1, "'second date'.Get_Date is not -1.");
      end;
   end Date_2;

end Test_Date.Read;

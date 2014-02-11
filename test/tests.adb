package body Tests is

   procedure Initialize (T : in out Test) is
   begin
      Set_Name (T, "My tests");
      Ahven.Framework.Add_Test_Routine (T, Test_Test'Access, "Test");
   end Initialize;

   procedure Test_Test is
      Result : boolean := True = True;
   begin
      Ahven.Assert (Result, "True is not True.");
   end Test_Test;

end Tests;

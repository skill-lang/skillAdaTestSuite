package body Test_Floats.Write is
   File_Name : constant String := "tmp/test-floats-write.sf";

   procedure Initialize (T : in out Test) is
   begin
      Set_Name (T, "Test_Floats.Write");
      Ahven.Framework.Add_Test_Routine (T, Float'Access, "test float");
      Ahven.Framework.Add_Test_Routine (T, Double'Access, "test double");
   end Initialize;

   procedure Set_Up (T : in out Test) is
      State : access Skill_State := new Skill_State;
   begin
      Skill.Read (State, "resources/float.check9220858943794241342.sf");
      Skill.Write (State, File_Name);
   end Set_Up;

   procedure Tear_Down (T : in out Test) is
   begin
      Ada.Directories.Delete_File (File_Name);
   end Tear_Down;

   procedure Float (T : in out Ahven.Framework.Test_Case'Class) is
      State : access Skill_State := new Skill_State;
   begin
      Skill.Read (State, File_Name);

      declare
         X : Float_Test_Type_Access := Get_Float_Test (State, 1);
      begin
         Ahven.Assert (X.Get_Zero = 0.0, "is not zero");
         Ahven.Assert (X.Get_MinusZero = -0.0, "is not minus zero");
         Ahven.Assert (X.Get_Zero = X.Get_MinusZero, "zero /= minus zero");
         Ahven.Assert (X.Get_Two = 2.0, "is not two");
         Ahven.Assert (X.Get_Pi = Ada.Numerics.Pi, "is not PI");
         Ahven.Assert (X.Get_NaN /= X.Get_NaN, "is not NaN");
      end;
   end Float;

   procedure Double (T : in out Ahven.Framework.Test_Case'Class) is
      State : access Skill_State := new Skill_State;
   begin
      Skill.Read (State, File_Name);

      declare
         X : Double_Test_Type_Access := Get_Double_Test (State, 1);
      begin
         Ahven.Assert (X.Get_Zero = 0.0, "is not zero");
         Ahven.Assert (X.Get_MinusZero = -0.0, "is not minus zero");
         Ahven.Assert (X.Get_Zero = X.Get_MinusZero, "zero /= minus zero");
         Ahven.Assert (X.Get_Two = 2.0, "is not two");
         Ahven.Assert (X.Get_Pi = Ada.Numerics.Pi, "is not PI");
         Ahven.Assert (X.Get_NaN /= X.Get_NaN, "is not NaN");
      end;
   end Double;

end Test_Floats.Write;

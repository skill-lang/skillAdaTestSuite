package body Test_Constants.Write is
   File_Name : constant String := "tmp/test-constants-write.sf";

   procedure Initialize (T : in out Test) is
   begin
      Set_Name (T, "Test_Constants.Write");
      Ahven.Framework.Add_Test_Routine (T, A'Access, "A: i8 = 8");
      Ahven.Framework.Add_Test_Routine (T, B'Access, "B: i16 = 16");
      Ahven.Framework.Add_Test_Routine (T, C'Access, "C: i32 = 32");
      Ahven.Framework.Add_Test_Routine (T, D'Access, "D: i64 = 64");
      Ahven.Framework.Add_Test_Routine (T, E'Access, "E: v64 = 46");
   end Initialize;

   procedure Set_Up (T : in out Test) is
      State : access Skill_State := new Skill_State;
   begin
      Skill.Create (State);

      for I in 1 .. 7 loop
         New_Constant (State);
      end loop;

      Skill.Write (State, File_Name);
   end Set_Up;

   procedure Tear_Down (T : in out Test) is
   begin
      Ada.Directories.Delete_File (File_Name);
   end Tear_Down;

   procedure A (T : in out Ahven.Framework.Test_Case'Class) is
      State : access Skill_State := new Skill_State;
   begin
      Skill.Read (State, File_Name);

      declare
         X : Constant_Type_Accesses := Get_Constants (State);
      begin
         for I in X'Range loop
            Ahven.Assert (8 = X (I).Get_A, "constant is not 8");
         end loop;
      end;
   end A;

   procedure B (T : in out Ahven.Framework.Test_Case'Class) is
      State : access Skill_State := new Skill_State;
   begin
      Skill.Read (State, File_Name);

      declare
         X : Constant_Type_Accesses := Get_Constants (State);
      begin
         for I in X'Range loop
            Ahven.Assert (16 = X (I).Get_B, "constant is not 16");
         end loop;
      end;
   end B;

   procedure C (T : in out Ahven.Framework.Test_Case'Class) is
      State : access Skill_State := new Skill_State;
   begin
      Skill.Read (State, File_Name);

      declare
         X : Constant_Type_Accesses := Get_Constants (State);
      begin
         for I in X'Range loop
            Ahven.Assert (32 = X (I).Get_C, "constant is not 32");
         end loop;
      end;
   end C;

   procedure D (T : in out Ahven.Framework.Test_Case'Class) is
      State : access Skill_State := new Skill_State;
   begin
      Skill.Read (State, File_Name);

      declare
         X : Constant_Type_Accesses := Get_Constants (State);
      begin
         for I in X'Range loop
            Ahven.Assert (64 = X (I).Get_D, "constant is not 64");
         end loop;
      end;
   end D;

   procedure E (T : in out Ahven.Framework.Test_Case'Class) is
      State : access Skill_State := new Skill_State;
   begin
      Skill.Read (State, File_Name);

      declare
         X : Constant_Type_Accesses := Get_Constants (State);
      begin
         for I in X'Range loop
            Ahven.Assert (46 = X (I).Get_E, "constant is not 46");
         end loop;
      end;
   end E;

end Test_Constants.Write;

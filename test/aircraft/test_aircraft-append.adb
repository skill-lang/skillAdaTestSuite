package body Test_Aircraft.Append is
   File_Name : constant String := "tmp/test-append-aircraft.sf";

   procedure Initialize (T : in out Test) is
   begin
      Set_Name (T, "Test_Aircraft.Append");
      Ahven.Framework.Add_Test_Routine (T, Create_Write_Read_Append_Write_Read'Access, "create, write, read, append, write, read");
      Ahven.Framework.Add_Test_Routine (T, Check_Tags_After_Append'Access, "check tags after append");
   end Initialize;

   procedure Set_Up (T : in out Test) is
      State : access Skill_State := new Skill_State;
   begin
      Skill.Create (State);

      New_Airplane (State, SU.To_Unbounded_String ("Fokker 100"), True, 1);
      New_Airplane (State, SU.To_Unbounded_String ("Bombardier Dash 8"), False, 2);

      New_Helicopter (State, SU.To_Unbounded_String ("Bell 206"), False, 1);
      New_Helicopter (State, SU.To_Unbounded_String ("Sikorsky S-76C+"), True, 2);

      Skill.Write (State, File_Name);
   end Set_Up;

   procedure Tear_Down (T : in out Test) is
   begin
      Ada.Directories.Delete_File (File_Name);
   end Tear_Down;

   procedure Create_Write_Read_Append_Write_Read (T : in out Ahven.Framework.Test_Case'Class) is
      use Ada.Strings.Unbounded;
   begin
      declare
         State : access Skill_State := new Skill_State;
      begin
         Skill.Read (State, File_Name);
         New_Airplane (State, SU.To_Unbounded_String ("General Dynamics F-16"), False, 14);
         New_Airplane (State, SU.To_Unbounded_String ("Cessna 172"), False, 102);
         Skill.Append (State, File_Name);
      end;

      declare
         State : access Skill_State := new Skill_State;
      begin
         Skill.Read (State, File_Name);

         declare
            X : Airplane_Type_Access := Skill.Get_Airplane (State, 1);
         begin
            Ahven.Assert (X.Get_Id = 1, "'first airplane'.Get_Id is not 1.");
            Ahven.Assert (X.Get_Name = "Fokker 100", "'first airplane'.Get_Name is not 'Fokker 100'.");
            Ahven.Assert (X.Get_Operational = True, "'first airplane'.Get_Operational is not true.");
         end;

         Ahven.Assert (Get_Airplane (State, 1).Get_Name = "Fokker 100", "Get_Name is not 'Fokker 100'.");
         Ahven.Assert (Get_Airplane (State, 2).Get_Name = "Bombardier Dash 8", "Get_Name is not 'Bombardier Dash 8'.");
         Ahven.Assert (Get_Airplane (State, 3).Get_Name = "General Dynamics F-16", "Get_Name is not 'General Dynamics F-16'.");
         Ahven.Assert (Get_Airplane (State, 4).Get_Name = "Cessna 172", "Get_Name is not 'Cessna 172'.");
      end;
   end Create_Write_Read_Append_Write_Read;

   procedure Check_Tags_After_Append (T : in out Ahven.Framework.Test_Case'Class) is
      use Ada.Strings.Unbounded;
   begin
      declare
         State : access Skill_State := new Skill_State;
      begin
         Skill.Read (State, File_Name);
         New_Airplane (State, SU.To_Unbounded_String ("General Dynamics F-16"), False, 14);
         New_Helicopter (State, SU.To_Unbounded_String ("Sikorsky R-4"), True, 99);
         New_Airplane (State, SU.To_Unbounded_String ("Cessna 172"), False, 102);
         Skill.Append (State, File_Name);
      end;

      declare
         use Ada.Tags;

         State : access Skill_State := new Skill_State;
      begin
         Skill.Read (State, File_Name);
         Ahven.Assert (Skill_Type_Access (Get_Aircraft (State, 1))'Tag = Airplane_Type'Tag, "1 is not a airplane type.");
         Ahven.Assert (Skill_Type_Access (Get_Aircraft (State, 2))'Tag = Airplane_Type'Tag, "2 is not a airplane type.");
         Ahven.Assert (Skill_Type_Access (Get_Aircraft (State, 3))'Tag = Helicopter_Type'Tag, "3 is not a helicopter type.");
         Ahven.Assert (Skill_Type_Access (Get_Aircraft (State, 4))'Tag = Helicopter_Type'Tag, "4 is not a helicopter type.");
         Ahven.Assert (Skill_Type_Access (Get_Aircraft (State, 5))'Tag = Airplane_Type'Tag, "5 is not a airplane type.");
         Ahven.Assert (Skill_Type_Access (Get_Aircraft (State, 6))'Tag = Airplane_Type'Tag, "6 is not a airplane type.");
         Ahven.Assert (Skill_Type_Access (Get_Aircraft (State, 7))'Tag = Helicopter_Type'Tag, "7 is not a helicopter type.");

         Ahven.Assert (Get_Aircraft (State, 4).Get_Operational = True, "aircraft 4 Get_Operational is not true");
         Ahven.Assert (Get_Aircraft (State, 5).Get_Operational = False, "aircraft 5 Get_Operational is not false");
         Ahven.Assert (Get_Aircraft (State, 6).Get_Operational = False, "aircraft 6 Get_Operational is not false");
         Ahven.Assert (Get_Aircraft (State, 7).Get_Operational = True, "aircraft 7 Get_Operational is not true");

         Ahven.Assert (Get_Aircraft (State, 3).Get_Name = "Bell 206", "aircraft 3 Get_Name is not 'Bell 206'");
         Ahven.Assert (Get_Aircraft (State, 6).Get_Name = "Cessna 172", "aircraft 6 Get_Name is not 'Cessna 172'");
         Ahven.Assert (Get_Aircraft (State, 7).Get_Name = "Sikorsky R-4", "aircraft 7 Get_Name is not 'Sikorsky R-4'");

         Ahven.Assert (Get_Helicopter (State, 1).Get_Id = 1, "helicopter 1 Get_Id is not 1");
         Ahven.Assert (Get_Helicopter (State, 2).Get_Id = 2, "helicopter 2 Get_Id is not 2");
         Ahven.Assert (Get_Helicopter (State, 3).Get_Id = 99, "helicopter 3 Get_Id is not 99");
      end;
   end Check_Tags_After_Append;

end Test_Aircraft.Append;

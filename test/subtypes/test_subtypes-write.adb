package body Test_Subtypes.Write is
   File_Name : constant String := "tmp/test-subtypes-write.sf";

   procedure Initialize (T : in out Test) is
   begin
      Set_Name (T, "Test_Subtypes.Write");
      Ahven.Framework.Add_Test_Routine (T, Check_Types'Access, "read written subtypes");
      Ahven.Framework.Add_Test_Routine (T, Check_Fields_A'Access, "a: all fields are self-references");
      Ahven.Framework.Add_Test_Routine (T, Check_Fields_B'Access, "b: all fields are self-references");
      Ahven.Framework.Add_Test_Routine (T, Check_Fields_C'Access, "c: all fields are self-references");
      Ahven.Framework.Add_Test_Routine (T, Check_Fields_D'Access, "d: all fields are self-references");
   end Initialize;

   procedure Set_Up (T : in out Test) is
      State : access Skill_State := new Skill_State;
   begin
      Skill.Read (State, "resources/localBasePoolStartIndex.sf");
      Skill.Write (State, File_Name);
   end Set_Up;

   procedure Tear_Down (T : in out Test) is
   begin
      Ada.Directories.Delete_File (File_Name);
   end Tear_Down;

   procedure Check_Types (T : in out Ahven.Framework.Test_Case'Class) is
      use Ada.Characters.Handling;
      use Ada.Strings.Fixed;
      use Ada.Tags;

      State : access Skill_State := new Skill_State;
   begin
      Skill.Read (State, File_Name);

      declare
         Types : constant String := "aaabbbbbdddcc";
      begin
         for I in Types'Range loop
            declare
               Object : Skill_Type'Class := Get_A (State, I).all;
               C : Character := To_Lower (Expanded_Name (Object'Tag)(10));
            begin
               Ahven.Assert (Types (I) = C, "index " & Trim (I'Img, Ada.Strings.Left));
            end;
         end loop;
      end;
   end Check_Types;

   procedure Check_Fields_A (T : in out Ahven.Framework.Test_Case'Class) is
      use Ada.Strings.Fixed;

      State : access Skill_State := new Skill_State;
   begin
      Skill.Read (State, File_Name);

      for I in 1 .. As_Size (State) loop
         declare
            X : A_Type_Access := Get_A (State, I);
         begin
            Ahven.Assert (X = X.Get_A, "index " & Trim (I'Img, Ada.Strings.Left));
         end;
      end loop;
   end Check_Fields_A;

   procedure Check_Fields_B (T : in out Ahven.Framework.Test_Case'Class) is
      use Ada.Strings.Fixed;

      State : access Skill_State := new Skill_State;
   begin
      Skill.Read (State, File_Name);

      for I in 1 .. Bs_Size (State) loop
         declare
            X : B_Type_Access := Get_B (State, I);
         begin
            Ahven.Assert (X = X.Get_B, "index " & Trim (I'Img, Ada.Strings.Left));
         end;
      end loop;
   end Check_Fields_B;

   procedure Check_Fields_C (T : in out Ahven.Framework.Test_Case'Class) is
      use Ada.Strings.Fixed;

      State : access Skill_State := new Skill_State;
   begin
      Skill.Read (State, File_Name);

      for I in 1 .. Cs_Size (State) loop
         declare
            X : C_Type_Access := Get_C (State, I);
         begin
            Ahven.Assert (X = X.Get_C, "index " & Trim (I'Img, Ada.Strings.Left));
         end;
      end loop;
   end Check_Fields_C;

   procedure Check_Fields_D (T : in out Ahven.Framework.Test_Case'Class) is
      use Ada.Strings.Fixed;

      State : access Skill_State := new Skill_State;
   begin
      Skill.Read (State, File_Name);

      for I in 1 .. Ds_Size (State) loop
         declare
            X : D_Type_Access := Get_D (State, I);
         begin
            Ahven.Assert (X = X.Get_D, "index " & Trim (I'Img, Ada.Strings.Left));
         end;
      end loop;
   end Check_Fields_D;

end Test_Subtypes.Write;

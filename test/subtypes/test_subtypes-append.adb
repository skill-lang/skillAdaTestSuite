package body Test_Subtypes.Append is
   File_Name : constant String := "tmp/test-append-subtypes.sf";

   procedure Initialize (T : in out Test) is
   begin
      Set_Name (T, "Test_Subtypes.Append");
      Ahven.Framework.Add_Test_Routine (T, Check_Types'Access, "create, writte, 2x append subtypes");
      Ahven.Framework.Add_Test_Routine (T, Check_Fields'Access, "all fields are self-references");
      Ahven.Framework.Add_Test_Routine (T, Check_Fields_A'Access, "a: all fields are self-references");
      Ahven.Framework.Add_Test_Routine (T, Check_Fields_B'Access, "b: all fields are self-references");
      Ahven.Framework.Add_Test_Routine (T, Check_Fields_C'Access, "c: all fields are self-references");
      Ahven.Framework.Add_Test_Routine (T, Check_Fields_D'Access, "d: all fields are self-references");
   end Initialize;

   procedure Set_Up (T : in out Test) is
      State : access Skill_State := new Skill_State;

      procedure Add_A is
         A : A_Type_Access := New_A (State, null);
      begin
         A.Set_A (A);
      end Add_A;

      procedure Add_B is
         B : B_Type_Access := New_B (State, null, null);
      begin
         B.Set_A (A_Type_Access (Skill_Type_Access (B)));
         B.Set_B (B);
      end Add_B;

      procedure Add_C is
         C : C_Type_Access := New_C (State, null, null);
      begin
         C.Set_A (A_Type_Access (Skill_Type_Access (C)));
         C.Set_C (C);
      end Add_C;

      procedure Add_D is
         D : D_Type_Access := New_D (State, null, null, null);
      begin
         D.Set_A (A_Type_Access (Skill_Type_Access (D)));
         D.Set_B (B_Type_Access (Skill_Type_Access (D)));
         D.Set_D (D);
      end Add_D;
   begin
      Skill.Create (State);
      Add_C;
      Add_A;
      Add_B;
      Add_A;
      Add_B;
      Add_B;
      Skill.Write (State, File_Name);
      Add_B;
      Add_D;
      Add_B;
      Add_D;
      Skill.Append (State, File_Name);
      Add_A;
      Add_D;
      Add_C;
      Skill.Append (State, File_Name);
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
         Types : constant String := "aabbbcbbddadc";
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

   procedure Check_Fields (T : in out Ahven.Framework.Test_Case'Class) is
      use Ada.Strings.Fixed;

      State : access Skill_State := new Skill_State;
   begin
      Skill.Read (State, File_Name);

      Ahven.Assert (Get_A (State, 3) = Get_A (State, 3).Get_A, "index 3: a");
      Ahven.Assert (B_Type_Access (Skill_Type_Access (Get_A (State, 3))) = B_Type_Access (Skill_Type_Access (Get_A (State, 3))).Get_B, "index 3: b");
      Ahven.Assert (B_Type_Access (Skill_Type_Access (Get_A (State, 4))) = B_Type_Access (Skill_Type_Access (Get_A (State, 4))).Get_B, "index 4: b");
      Ahven.Assert (B_Type_Access (Skill_Type_Access (Get_A (State, 5))) = B_Type_Access (Skill_Type_Access (Get_A (State, 5))).Get_B, "index 5: b");

      Ahven.Assert (B_Type_Access (Skill_Type_Access (Get_A (State, 9))) = B_Type_Access (Skill_Type_Access (Get_A (State, 9))).Get_B, "index 9: b");
      Ahven.Assert (D_Type_Access (Skill_Type_Access (Get_A (State, 9))) = D_Type_Access (Skill_Type_Access (Get_A (State, 9))).Get_D, "index 9: d");

      Ahven.Assert (C_Type_Access (Skill_Type_Access (Get_A (State, 13))) = C_Type_Access (Skill_Type_Access (Get_A (State, 13))).Get_C, "index 13: c");
   end Check_Fields;

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

end Test_Subtypes.Append;

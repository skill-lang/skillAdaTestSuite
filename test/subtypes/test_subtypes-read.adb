package body Test_Subtypes.Read is

   procedure Initialize (T : in out Test) is
   begin
      Set_Name (T, "Test_Subtypes.Read");
      Ahven.Framework.Add_Test_Routine (T, Check_Types'Access, "subtypes read; see paragraph 6.3.2");
      Ahven.Framework.Add_Test_Routine (T, Check_Fields_A'Access, "a: all fields are self-references");
      Ahven.Framework.Add_Test_Routine (T, Check_Fields_B'Access, "b: all fields are self-references");
      Ahven.Framework.Add_Test_Routine (T, Check_Fields_C'Access, "c: all fields are self-references");
      Ahven.Framework.Add_Test_Routine (T, Check_Fields_D'Access, "d: all fields are self-references");
   end Initialize;

   procedure Check_Types is
      use Ada.Characters.Handling;
      use Ada.Strings.Fixed;
      use Ada.Tags;

      State : access Skill_State := new Skill_State;
   begin
      Skill.Read (State, "resources/localBasePoolStartIndex.sf");

      declare
         X : A_Type_Accesses := Skill.Get_As (State);
         Types : constant String := "aabbbcbbddacd";
      begin
         for I in Types'Range loop
            declare
               Object : Skill_Type'Class := X (I).all;
               C : Character := To_Lower (Expanded_Name (Object'Tag)(10));
            begin
               Ahven.Assert (Types (I) = C, "index " & Trim (I'Img, Ada.Strings.Left));
            end;
         end loop;
      end;
   end Check_Types;

   procedure Check_Fields_A is
      use Ada.Strings.Fixed;

      State : access Skill_State := new Skill_State;
   begin
      Skill.Read (State, "resources/localBasePoolStartIndex.sf");

      declare
         X : A_Type_Accesses := Skill.Get_As (State);
      begin
         for I in X'Range loop
            Ahven.Assert (X (I) = X (I).Get_A, "index " & Trim (I'Img, Ada.Strings.Left));
         end loop;
      end;
   end Check_Fields_A;

   procedure Check_Fields_B is
      use Ada.Strings.Fixed;

      State : access Skill_State := new Skill_State;
   begin
      Skill.Read (State, "resources/localBasePoolStartIndex.sf");

      declare
         X : B_Type_Accesses := Skill.Get_Bs (State);
      begin
         for I in X'Range loop
            Ahven.Assert (X (I) = X (I).Get_B, "index " & Trim (I'Img, Ada.Strings.Left));
         end loop;
      end;
   end Check_Fields_B;

   procedure Check_Fields_C is
      use Ada.Strings.Fixed;

      State : access Skill_State := new Skill_State;
   begin
      Skill.Read (State, "resources/localBasePoolStartIndex.sf");

      declare
         X : C_Type_Accesses := Skill.Get_Cs (State);
      begin
         for I in X'Range loop
            Ahven.Assert (X (I) = X (I).Get_C, "index " & Trim (I'Img, Ada.Strings.Left));
         end loop;
      end;
   end Check_Fields_C;

   procedure Check_Fields_D is
      use Ada.Strings.Fixed;

      State : access Skill_State := new Skill_State;
   begin
      Skill.Read (State, "resources/localBasePoolStartIndex.sf");

      declare
         X : D_Type_Accesses := Skill.Get_Ds (State);
      begin
         for I in X'Range loop
            Ahven.Assert (X (I) = X (I).Get_D, "index " & Trim (I'Img, Ada.Strings.Left));
         end loop;
      end;
   end Check_Fields_D;

end Test_Subtypes.Read;

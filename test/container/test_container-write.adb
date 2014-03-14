package body Test_Container.Write is
   File_Name : constant String := "tmp/test-container-write.sf";

   procedure Initialize (T : in out Test) is
   begin
      Set_Name (T, "Test_Container.Write");
      Ahven.Framework.Add_Test_Routine (T, Constant_Length_Array'Access, "constant length array: 7, 49, 343");
      Ahven.Framework.Add_Test_Routine (T, Variable_Length_Array'Access, "variable length array: 9, 81, 729");
      Ahven.Framework.Add_Test_Routine (T, List'Access, "list with 100 numbers");
      Ahven.Framework.Add_Test_Routine (T, Set'Access, "set with 100 numbers");
      Ahven.Framework.Add_Test_Routine (T, Map'Access, "3 strings and some numbers");
   end Initialize;

   procedure Set_Up (T : in out Test) is
      State : access Skill_State := new Skill_State;
   begin
      Skill.Create (State);

      declare
         arr : Container_Arr_Array := (7, 49, 343);
         varr : Container_Varr_Vector.Vector;
         l : Container_L_List.List;
         s : Container_S_Set.Set;
         f : Container_F_Map_1.Map;
         someset : Container_Someset_Set.Set;
      begin
         for I in 1 .. Long (3) loop
            varr.Append (9 ** Natural (I));
         end loop;

         for I in 1 .. Long (100) loop
            l.Append (I);
         end loop;

         for I in 1 .. Long (999) loop
            s.Insert (I);
         end loop;

         declare
            a : Container_F_Map_2.Map;
            b : Container_F_Map_2.Map;
            c : Container_F_Map_2.Map;
         begin
            a.Insert (1, 2);
            a.Insert (2, 3);
            a.Insert (3, 4);
            b.Insert (1, 360);
            c.Insert (2, 1024);
            c.Insert (4, 512);
            c.Insert (8, 256);
            c.Insert (16, 128);
            c.Insert (32, 64);
            f.Insert (SU.To_Unbounded_String ("a"), a);
            f.Insert (SU.To_Unbounded_String ("b"), b);
            f.Insert (SU.To_Unbounded_String ("c"), c);
         end;

         New_Container (State, arr, varr, l, s, f, someset);
      end;

      Skill.Write (State, File_Name);
   end Set_Up;

   procedure Tear_Down (T : in out Test) is
   begin
      Ada.Directories.Delete_File (File_Name);
   end Tear_Down;

   procedure Constant_Length_Array (T : in out Ahven.Framework.Test_Case'Class) is
      State : access Skill_State := new Skill_State;
   begin
      Skill.Read (State, File_Name);

      declare
         X : Container_Type_Accesses := Get_Containers (State);
         arr : Container_Arr_Array := X (1).Get_Arr;
      begin
         for I in arr'Range loop
            Ahven.Assert (7 ** I = arr (I), Integer'Image (7 ** I) & " /= " & arr (I)'Img);
         end loop;
      end;
   end Constant_Length_Array;

   procedure Variable_Length_Array (T : in out Ahven.Framework.Test_Case'Class) is
      State : access Skill_State := new Skill_State;
   begin
      Skill.Read (State, File_Name);

      declare
         use Container_Varr_Vector;

         X : Container_Type_Accesses := Get_Containers (State);
         varr : Container_Varr_Vector.Vector := X (1).Get_Varr;

         procedure Iterate (Position : Cursor) is
         begin
            Ahven.Assert (9 ** To_Index (Position) = Element (Position), Integer'Image (9 ** To_Index (Position)) & " /= " & Element (Position)'Img);
         end Iterate;
         pragma Inline (Iterate);
      begin
         varr.Iterate (Iterate'Access);
      end;
   end Variable_Length_Array;

   procedure List (T : in out Ahven.Framework.Test_Case'Class) is
      State : access Skill_State := new Skill_State;
   begin
      Skill.Read (State, File_Name);

      declare
         use Container_L_List;

         X : Container_Type_Accesses := Get_Containers (State);
         l : Container_L_List.List := X (1).Get_L;
         I : Long := 1;

         procedure Iterate (Position : Cursor) is
         begin
            Ahven.Assert (I = Long (Element (Position)), Long'Image (I) & " /= " & Element (Position)'Img);
            I := I + 1;
         end Iterate;
         pragma Inline (Iterate);
      begin
         l.Iterate (Iterate'Access);
      end;
   end List;

   procedure Set (T : in out Ahven.Framework.Test_Case'Class) is
      State : access Skill_State := new Skill_State;
   begin
      Skill.Read (State, File_Name);

      declare
         use Container_S_Set;

         X : Container_Type_Accesses := Get_Containers (State);
         s : Container_S_Set.Set := X (1).Get_S;
         I : Long := 1;

         procedure Iterate (Position : Cursor) is
         begin
            Ahven.Assert (I = Long (Element (Position)), Long'Image (I) & " /= " & Element (Position)'Img);
            I := I + 1;
         end Iterate;
         pragma Inline (Iterate);
      begin
         s.Iterate (Iterate'Access);
      end;
   end Set;

   procedure Map (T : in out Ahven.Framework.Test_Case'Class) is
      State : access Skill_State := new Skill_State;
   begin
      Skill.Read (State, File_Name);

      declare
         use Container_F_Map_1;

         X : Container_Type_Accesses := Get_Containers (State);
         f : Container_F_Map_1.Map := X (1).Get_F;
      begin
         Ahven.Assert (f.Contains (SU.To_Unbounded_String ("a")), "f does not contain string a");
         Ahven.Assert (f.Contains (SU.To_Unbounded_String ("c")), "f does not contain string b");
         Ahven.Assert (f.Contains (SU.To_Unbounded_String ("b")), "f does not contain string c");
         Ahven.Assert (not f.Contains (SU.To_Unbounded_String ("d")), "f does contain string d");

         declare
            a : Container_F_Map_2.Map := f.Element (SU.To_Unbounded_String ("a"));
            b : Container_F_Map_2.Map := f.Element (SU.To_Unbounded_String ("b"));
            c : Container_F_Map_2.Map := f.Element (SU.To_Unbounded_String ("c"));
         begin
            Ahven.Assert (a.Contains (1), "a does not contain 1");
            Ahven.Assert (a.Contains (2), "a does not contain 2");
            Ahven.Assert (a.Contains (3), "a does not contain 3");
            Ahven.Assert (not a.Contains (4), "a does contain 4");
            Ahven.Assert (a.Element (1) = 2, "a -/> (1, 2)");
            Ahven.Assert (a.Element (2) = 3, "a -/> (2, 3)");
            Ahven.Assert (a.Element (3) = 4, "a -/> (3, 4)");

            Ahven.Assert (b.Contains (1), "b does not contain 1");
            Ahven.Assert (not b.Contains (360), "b does contain 360");

            Ahven.Assert (5 = Natural (c.Length), "c does not contain 5 elements");
            Ahven.Assert (c.Element (2) = 1024, "c -/> (2, 1024)");
            Ahven.Assert (c.Element (4) = 512, "c -/> (4, 512)");
            Ahven.Assert (c.Element (8) = 256, "c -/> (8, 256)");
            Ahven.Assert (c.Element (16) = 128, "c -/> (16, 128)");
            Ahven.Assert (c.Element (32) = 64, "c -/> (32, 64)");
         end;
      end;
   end Map;

end Test_Container.Write;

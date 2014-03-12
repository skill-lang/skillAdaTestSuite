package body Test_Container.Read is

   procedure Initialize (T : in out Test) is
   begin
      Set_Name (T, "Test_Container.Read");
      Ahven.Framework.Add_Test_Routine (T, Constant_Length_Array'Access, "constant length array: 0, 0, 0");
      Ahven.Framework.Add_Test_Routine (T, Variable_Length_Array'Access, "variable length array: 1, 2, 3");
      Ahven.Framework.Add_Test_Routine (T, List'Access, "empty list");
      Ahven.Framework.Add_Test_Routine (T, Set'Access, "set: 0");
      Ahven.Framework.Add_Test_Routine (T, Map'Access, "f -> (0, 0)");
   end Initialize;

   procedure Constant_Length_Array is
      State : access Skill_State := new Skill_State;
   begin
      Skill.Read (State, "resources/container.sf");

      declare
         X : Container_Type_Accesses := Skill.Get_Containers (State);
         Arr : Container_Arr_Array := X (1).Get_Arr;
      begin
         for I in 1 .. 3 loop
            Ahven.Assert (0 = Arr (I), "not three zeros");
         end loop;
      end;
   end Constant_Length_Array;

   procedure Variable_Length_Array is
      use Container_Varr_Vector;

      State : access Skill_State := new Skill_State;
   begin
      Skill.Read (State, "resources/container.sf");

      declare
         X : Container_Type_Accesses := Skill.Get_Containers (State);
         Varr : Container_Varr_Vector.Vector := X (1).Get_Varr;
      begin
         Ahven.Assert (3 = Natural (Varr.Length), "length is not 3");
         for I in 1 .. 3 loop
            Ahven.Assert (Long (I) = Varr.Element (I), "elements are not 1, 2, 3");
         end loop;
      end;
   end Variable_Length_Array;

   procedure List is
      use Container_L_List;

      State : access Skill_State := new Skill_State;
   begin
      Skill.Read (State, "resources/container.sf");

      declare
         X : Container_Type_Accesses := Skill.Get_Containers (State);
         L : Container_L_List.List := X (1).Get_L;
      begin
         Ahven.Assert (L.Is_Empty, "is not empty");
      end;
   end List;

   procedure Set is
      use Container_S_Set;

      State : access Skill_State := new Skill_State;
   begin
      Skill.Read (State, "resources/container.sf");

      declare
         X : Container_Type_Accesses := Skill.Get_Containers (State);
         S : Container_S_Set.Set := X (1).Get_S;
      begin
         Ahven.Assert (1 = Natural (S.Length), "length is not 0");
         Ahven.Assert (S.Contains (0), "element is not 0");
      end;
   end Set;

   procedure Map is
      State : access Skill_State := new Skill_State;
   begin
      Skill.Read (State, "resources/container.sf");

      declare
         X : Container_Type_Accesses := Get_Containers (State);

         procedure Iterate_2 (Position : Container_F_Map_2.Cursor) is
            K : v64 := Container_F_Map_2.Key (Position);
            V : v64 := Container_F_Map_2.Element (Position);
         begin
            Ahven.Assert (0 = K, "key is not 0");
            Ahven.Assert (0 = V, "value is not 0");
         end Iterate_2;

         procedure Iterate (Position : Container_F_Map_1.Cursor) is
            K : SU.Unbounded_String := Container_F_Map_1.Key (Position);
            M : Container_F_Map_2.Map := Container_F_Map_1.Element (Position);
         begin
            Ahven.Assert ("f" = SU.To_String (K), "string is not f");
            M.Iterate (Iterate_2'Access);
         end Iterate;
      begin
         for I in X'Range loop
            declare
               M : Container_F_Map_1.Map := X (I).Get_F;
            begin
               M.Iterate (Iterate'Access);
            end;
         end loop;
      end;
   end Map;

end Test_Container.Read;

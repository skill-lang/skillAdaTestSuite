package body Test_Container.Read is

   procedure Initialize (T : in out Test) is
   begin
      Set_Name (T, "Test_Container.Read");
      Ahven.Framework.Add_Test_Routine (T, Constant_Length_Array'Access, "constant length array: 0, 0, 0");
      Ahven.Framework.Add_Test_Routine (T, Variable_Length_Array'Access, "variable length array: 1, 2, 3");
      Ahven.Framework.Add_Test_Routine (T, List'Access, "empty list");
      Ahven.Framework.Add_Test_Routine (T, Set'Access, "set: 0");
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
         Ahven.Assert (0 = Natural (S.First_Element), "element is not 0");
      end;
   end Set;

end Test_Container.Read;

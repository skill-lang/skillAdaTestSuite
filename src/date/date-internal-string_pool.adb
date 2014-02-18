package body Date.Internal.String_Pool is

   String_Pool : String_Pool_Type_Access := new String_Pool_Type (1 .. 0);

   procedure Put (New_String_Pool : String_Pool_Type) is
      procedure Free is new Ada.Unchecked_Deallocation (String_Pool_Type, String_Pool_Type_Access);

      Old_String_Pool : String_Pool_Type (String_Pool'Range);
   begin
      --  copy current string pool
      for I in String_Pool'Range loop
         Old_String_Pool (I) := String_Pool (I);
      end loop;

      Free (String_Pool);
      String_Pool := new String_Pool_Type (1 .. Old_String_Pool'Length + New_String_Pool'Length);

      declare
         Copy_String_Pool : String_Pool_Type := Old_String_Pool & New_String_Pool;
      begin
         for I in Copy_String_Pool'Range loop
            String_Pool (I) := Copy_String_Pool (I);
         end loop;
      end;
   end Put;

   function Get (I : Long) return SU.Unbounded_String is (String_Pool (I));
   function Get (I : Long) return String is (SU.To_String (String_Pool (I)));
   function Get_All return String_Pool_Type_Access is (String_Pool);

end Date.Internal.String_Pool;

package body Date is

   --  hash map functions
   function Equivalent_Keys (Left, Right : SU.Unbounded_String) return Boolean is
      use SU;
   begin
      return Left = Right;
   end Equivalent_Keys;

   function Hash (Key : SU.Unbounded_String) return Ada.Containers.Hash_Type is
      (Ada.Strings.Hash (SU.To_String (Key)));

end Date;
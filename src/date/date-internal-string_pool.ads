with Ada.Unchecked_Deallocation;

package Date.Internal.String_Pool is

   type String_Pool_Type_Access is access String_Pool_Type;

   procedure Put (Next_String_Pool : String_Pool_Type);

   function Get (I : Long) return String;
   function Get_All return String_Pool_Type_Access;

end Date.Internal.String_Pool;

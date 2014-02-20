with Ada.Containers.Indefinite_Hashed_Maps;
with Ada.Containers.Indefinite_Vectors;
with Ada.Strings.Hash;

with Ada.Text_IO;

package Node is

   ------------
   --  types --
   ------------

   --  Short_Short_Integer
   subtype i8 is Short_Short_Integer'Base range -(2**7) .. +(2**7 - 1);

   --  Short_Integer
   subtype Short is Short_Integer'Base range -(2**15) .. +(2**15 - 1);
   subtype i16 is Short;

   --  Integer
   subtype i32 is Integer'Base range -(2**31) .. +(2**31 - 1);

   --  Long_Integer
   subtype Long is Long_Integer'Base range -(2**63) .. +(2**63 - 1);
   subtype i64 is Long;
   subtype v64 is Long;

   --  Float
   subtype f32 is Float;

   --  Long_Float
   subtype Double is Long_Float'Base;
   subtype f64 is Double;

   ------------------
   --  STRING POOL --
   ------------------
   package String_Pool_Vector is new Ada.Containers.Indefinite_Vectors (
      Index_Type => Positive,
      Element_Type => String
   );

   --------------------------
   --  FIELD DECLARATIONS  --
   --------------------------
   type Field_Declaration_Type (Size : Natural) is tagged
      record
         Field_Name : String (1 .. Size);
         Field_Type : Short_Short_Integer;
      end record;
   type Field_Declaration_Access is access all Field_Declaration_Type;

   package Field_Declaration_Vector is new Ada.Containers.Indefinite_Vectors (
      Index_Type => Positive,
      Element_Type => Field_Declaration_Access
   );

   -------------------------
   --  TYPE DECLARATIONS  --
   -------------------------
   type Type_Declaration_Type (Size : Natural) is
      record
         Type_Name : String (1 .. Size);
         Type_Super : Long;
         Type_Fields : Field_Declaration_Vector.Vector;
      end record;
   type Type_Declaration_Access is access all Type_Declaration_Type;

   package Type_Declaration_Hash_Map is new Ada.Containers.Indefinite_Hashed_Maps (
      Key_Type => String,
      Element_Type => Type_Declaration_Access,
      Hash => Ada.Strings.Hash,
      Equivalent_Keys => "="
   );

   --------------------------
   --  SERIALIZABLE STATE  --
   --------------------------
   protected type Serializable_State is

      --  string pool
      function Get_String (Position : Long) return String;
      procedure Put_String (Value : String);

      --  type declarations
      function Has_Type_Declaration (Value : String) return Boolean;
      procedure Put_Type_Declaration (Name : String; Super : Long);

      --  field declarations
      function Get_Known_Fields (Name : String) return Long;
      procedure Put_Field_Declaration (Type_Name, Field_Name : String; Field_Type : Short_Short_Integer);

   private

      String_Pool : String_Pool_Vector.Vector;
      Type_Declarations : Type_Declaration_Hash_Map.Map;

   end Serializable_State;

end Node;

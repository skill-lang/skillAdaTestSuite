with Ada.Containers.Indefinite_Hashed_Maps;
with Ada.Containers.Indefinite_Vectors;
with Ada.Strings.Hash;

with Ada.Text_IO;

package Node is

   -------------
   --  TYPES  --
   -------------
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

   -------------
   --  SKILL  --
   -------------
   type Skill_State is limited private;
   type Object is abstract tagged null record;

   type Node_Object is new Object with
      record
         id : i8;
      end record;

private

   ------------------
   --  STRING POOL --
   ------------------
   package String_Pool_Vector is new Ada.Containers.Indefinite_Vectors (Positive, String);

   --------------------
   --  STORAGE POOL  --
   --------------------
   package Storage_Pool_Vector is new Ada.Containers.Indefinite_Vectors (Positive, Object'Class);

   --------------------------
   --  FIELD DECLARATIONS  --
   --------------------------
   type Field_Declaration (Length : Natural) is tagged
      record
         Name : String (1 .. Length);
         F_Type : Short_Short_Integer;
      end record;
   type Field_Information is access Field_Declaration;

   package Field_Declaration_Vector is new Ada.Containers.Indefinite_Vectors
      (Index_Type => Positive, Element_Type => Field_Information);

   -------------------------
   --  TYPE DECLARATIONS  --
   -------------------------
   type Type_Declaration (Length : Natural) is
      record
         Name : String (1 .. Length);
         Super : Long;
         Fields : Field_Declaration_Vector.Vector;
         Storage : Storage_Pool_Vector.Vector;
      end record;
   type Type_Information is access Type_Declaration;

   package Type_Declaration_Hash_Map is new Ada.Containers.Indefinite_Hashed_Maps
      (String, Type_Information, Ada.Strings.Hash, "=");

   -------------------
   --  SKILL STATE  --
   -------------------
   protected type Skill_State is  --  Skill_State

      --  string pool
      function Get_String (Position : Long) return String;
      procedure Put_String (Value : String);

      --  type declarations
      function Has_Type_Declaration (Value : String) return Boolean;
      procedure Put_Type_Declaration (Name : String; Super : Long);

      --  field declarations
      function Get_Known_Fields (Name : String) return Long;
      procedure Put_Field_Declaration (Type_Name, Field_Name : String; Field_Type : Short_Short_Integer);

      procedure Put (X : Object'Class);

   private

      String_Pool : String_Pool_Vector.Vector;
      Storage_Pool : Storage_Pool_Vector.Vector;
      Types : Type_Declaration_Hash_Map.Map;

   end Skill_State;

end Node;

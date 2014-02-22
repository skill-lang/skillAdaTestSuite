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
   type Field_Declaration (Size : Positive) is tagged
      record
         Name : String (1 .. Size);
         F_Type : Short_Short_Integer;
      end record;
   type Field_Information is access Field_Declaration;

   package Fields_Vector is new Ada.Containers.Indefinite_Vectors
      (Index_Type => Positive, Element_Type => Field_Information);

   -------------------------
   --  TYPE DECLARATIONS  --
   -------------------------
   type Type_Declaration (Size : Positive) is
      record
         Name : String (1 .. Size);
         Super_Name : Long;
         Fields : Fields_Vector.Vector;
         Storage_Pool : Storage_Pool_Vector.Vector;
      end record;
   type Type_Information is access Type_Declaration;

   package Types_Hash_Map is new Ada.Containers.Indefinite_Hashed_Maps
      (String, Type_Information, Ada.Strings.Hash, "=");

   ------------------
   --  DATA CHUNKS --
   ------------------
   type Data_Chunk (Size : Positive) is record
      Type_Name : String (1 .. Size);
      Instances_Count : Long;
      Data_Length : Long;
      BPSI : Long;
   end record;

   package Data_Chunk_Vector is new Ada.Containers.Indefinite_Vectors (Positive, Data_Chunk);
   Data_Chunks : Data_Chunk_Vector.Vector;

   -------------------
   --  SKILL STATE  --
   -------------------
   protected type Skill_State is

      --  string pool
      function Get_String (Position : Long) return String;
      procedure Put_String (Value : String);

      --  storage pool
      function Get (Type_Name : String; Position : Positive) return Object'Class;
      function Length (Type_Name : String) return Natural;
      procedure Put (Type_Name : String; New_Object : Object'Class);

      --  field declarations
      function Known_Fields (Name : String) return Long;
      function Get_Field (Type_Name : String; Position : Long) return Field_Information;
      procedure Put_Field (Type_Name : String; New_Field : Field_Information);

      --  type declarations
      function Has_Type (Name : String) return Boolean;
      function Get_Type (Name : String) return Type_Information;
      procedure Put_Type (New_Type : Type_Information);

   private

      String_Pool : String_Pool_Vector.Vector;
      Types : Types_Hash_Map.Map;

   end Skill_State;

end Node;

with Ada.Containers.Hashed_Maps;
with Ada.Containers.Vectors;
with Ada.Strings.Hash;
with Ada.Strings.Unbounded;

with Ada.Text_IO;

package Date is

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

   type Date_Type is
      record
         date : Long;
      end record;

   -------------------
   --  skill state  --
   -------------------
   package SU renames Ada.Strings.Unbounded;
   use SU;

   package String_Pool_Vector is new Ada.Containers.Vectors (
      Index_Type => Positive,
      Element_Type => SU.Unbounded_String
   );

   function Equivalent_Keys (Left, Right : SU.Unbounded_String) return Boolean;
   function Hash (Key: SU.Unbounded_String) return Ada.Containers.Hash_Type;

   type Type_Declaration_Type is
      record
         name : SU.Unbounded_String;
      end record;

   package Type_Declarations_Hash_Map is new Ada.Containers.Hashed_Maps (
      Key_Type => SU.Unbounded_String,
      Element_Type => Type_Declaration_Type,
      Hash => Hash,
      Equivalent_Keys => Equivalent_Keys
   );

   type Skill_State_Type is
      record
         String_Pool : String_Pool_Vector.Vector;
         Type_Declarations : Type_Declarations_Hash_Map.Map;
         x : SU.Unbounded_String;
         instancesCount : Long := 0;
         fieldType : i8;
         knownFields : Long := 0;
      end record;
   type Skill_State is access all Skill_State_Type;

end Date;

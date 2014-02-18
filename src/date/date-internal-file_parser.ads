with Ada.Containers.Hashed_Maps;
with Ada.Containers.Vectors;
with Ada.Strings.Hash;
with Date.Internal.Byte_Reader;
with Date.Internal.String_Pool;

with Ada.Text_IO;

package Date.Internal.File_Parser is

   procedure Read (File_Name : String);

private

   function Equivalent_Keys (Left, Right : SU.Unbounded_String) return Boolean;
   function Hash (Key: SU.Unbounded_String) return Ada.Containers.Hash_Type;

   type Field_Declaration_Type is
      record
         ftype : Short_Short_Integer;
         name : SU.Unbounded_String;
         offset : Long;
      end record;

   package Field_Declarations_Vector is new Ada.Containers.Vectors (Positive, Field_Declaration_Type);

   type Type_Declaration_Type is
      record
         name : SU.Unbounded_String;
         super : Long;
         count : Long;
         lbpsi : Long;
         fields : Field_Declarations_Vector.Vector;
      end record;

   package Type_Declarations_Hash_Map is new Ada.Containers.Hashed_Maps (
      Key_Type => SU.Unbounded_String,
      Element_Type => Type_Declaration_Type,
      Hash => Hash,
      Equivalent_Keys => Equivalent_Keys
   );

   function Read_String_Block return String_Pool_Type;

   procedure Read_Type_Block;
   procedure Read_Type_Declaration;
   procedure Read_Field_Declaration (Type_Declaration : Type_Declaration_Type);
   procedure Read_Field_Data;

end Date.Internal.File_Parser;

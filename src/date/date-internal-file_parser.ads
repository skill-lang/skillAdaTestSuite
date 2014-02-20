with Date.Internal.Byte_Reader;
with Date.Internal.String_Pool;

package Date.Internal.File_Parser is

   procedure Read (pState : Skill_State; File_Name : String);

private

   type Data_Queue_Type is
      record
         type_name : SU.Unbounded_String;
         instances_count : Long;
      end record;

   package Data_Queue_Vector is new Ada.Containers.Vectors (
      Index_Type => Positive,
      Element_Type => Data_Queue_Type
   );

   procedure Read_String_Block;
   procedure Read_Type_Block;
   procedure Read_Type_Declaration;
   procedure Read_Field_Declaration (tname : SU.Unbounded_String);
   procedure Read_Field_Data;

end Date.Internal.File_Parser;

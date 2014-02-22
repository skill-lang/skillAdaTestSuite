with Node.Internal.Byte_Reader;

generic
package Node.Internal.File_Parser is

   procedure Read (pState : access Skill_State; File_Name : String);

private

   procedure Read_String_Block;
   procedure Read_Type_Block;
   procedure Read_Type_Declaration;
   procedure Read_Field_Declaration (Type_Name : String);
   procedure Read_Field_Data;

   procedure Data_Chunk_Vector_Iterator (Iterator : Data_Chunk_Vector.Cursor);
   procedure Skip_Restrictions;

end Node.Internal.File_Parser;

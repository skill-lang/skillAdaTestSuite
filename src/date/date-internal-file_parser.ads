with Date.Internal.Byte_Reader;
with Date.Internal.String_Pool;

package Date.Internal.File_Parser is

   procedure Read (State : Skill_State; File_Name : String);

private

   procedure Read_String_Block (State : Skill_State);
   procedure Read_Type_Block (State : Skill_State);
   procedure Read_Type_Declaration (State : Skill_State);
   procedure Read_Field_Declaration (State : Skill_State);
   procedure Read_Field_Data (State : Skill_State);

end Date.Internal.File_Parser;

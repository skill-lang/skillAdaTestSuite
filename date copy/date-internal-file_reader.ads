--  ___ _  ___ _ _                                                            --
-- / __| |/ (_) | |       Your SKilL Ada Binding                              --
-- \__ \ ' <| | | |__     <<debug>>                                           --
-- |___/_|\_\_|_|____|    by: <<some developer>>                              --
--                                                                            --

with Date.Internal.Byte_Reader;

package Date.Internal.File_Reader is

   procedure Read (pState : access Skill_State; File_Name : String);

private

   procedure Read_String_Block;
   procedure Read_Type_Block;
   procedure Read_Type_Declaration (Last_End : in out Long);
   procedure Read_Field_Declaration (Type_Name : String);
   procedure Read_Field_Data;
   procedure Update_Base_Pool_Start_Index;

   procedure Create_Objects (Type_Name : String; Instance_Count : Natural);
   procedure Data_Chunk_Vector_Iterator (Iterator : Data_Chunk_Vector.Cursor);
   procedure Skip_Restrictions;

end Date.Internal.File_Reader;

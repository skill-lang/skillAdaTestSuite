package body Date.Internal.Serializable_State is

   package ASS_IO renames Ada.Streams.Stream_IO;
   package File_Parser renames Date.Internal.File_Parser;

   procedure Read (State : Skill_State; File_Name : String) is
   begin
      File_Parser.Read (State, File_Name);
   end Read;

   procedure Write (State : Skill_State; File_Name : String) is
--      package Byte_Writer renames Date.Internal.Byte_Writer;

      Output_File : ASS_IO.File_Type;
      Output_Stream : ASS_IO.Stream_Access;
   begin
      ASS_IO.Create (Output_File, ASS_IO.Out_File, File_Name);
      Output_Stream := ASS_IO.Stream (Output_File);

      ASS_IO.Close (Output_File);
   end Write;

end Date.Internal.Serializable_State;

package body Date.Api.Skill_State is

   package Serializable_State renames Date.Internal.Serializable_State;

   procedure Create is
   begin
      null;
   end Create;

   procedure Read (State : Date.Skill_State; File_Name : String) is
   begin
--      Ada.Text_IO.Put_Line (State.String_Pool.Length'Img);
      Serializable_State.Read (State, File_Name);
   end Read;

   procedure Write (State : Date.Skill_State; File_Name : String) is
   begin
      Serializable_State.Write (State, File_Name);
   end Write;

end Date.Api.Skill_State;

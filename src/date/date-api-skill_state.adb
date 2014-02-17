package body Date.Api.Skill_State is

   package Serializable_State renames Date.Internal.Serializable_State;

   procedure Create is
   begin
      null;
   end Create;

   procedure Read (File_Name : String) is
   begin
      Serializable_State.Read (File_Name);
   end Read;

   procedure Write (File_Name : String) is
   begin
      Serializable_State.Write (File_Name);
   end Write;

end Date.Api.Skill_State;

package body Node.Api.Skill_State is

   procedure Read (State : access Serializable_State; File_Name : String) is
      package File_Parser is new Node.Internal.File_Parser;
   begin
      File_Parser.Read (State, File_Name);
   end Read;

end;

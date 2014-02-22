package body Node.Api.Skill is

   procedure Read (State : access Skill_State; File_Name : String) is
      package File_Parser is new Node.Internal.File_Parser;
   begin
      File_Parser.Read (State, File_Name);
   end Read;

   function Get_Nodes (State : access Skill_State) return Node_Objects is
      Length : Natural := State.Length ("node");
      rval : Node_Objects (1 .. Length);
   begin
      for I in rval'Range loop
         rval (I) := Node_Object (State.Get ("node", I));
      end loop;

      return rval;
   end Get_Nodes;

end Node.Api.Skill;

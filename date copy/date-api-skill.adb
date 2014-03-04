--  ___ _  ___ _ _                                                            --
-- / __| |/ (_) | |       Your SKilL Ada Binding                              --
-- \__ \ ' <| | | |__     <<debug>>                                           --
-- |___/_|\_\_|_|____|    by: <<some developer>>                              --
--                                                                            --

package body Date.Api.Skill is

   procedure Read (State : access Skill_State; File_Name : String) is
      package File_Reader renames Internal.File_Reader;
   begin
      File_Reader.Read (State, File_Name);
   end Read;

   procedure Write (State : access Skill_State; File_Name : String) is
      package File_Writer renames Internal.File_Writer;
   begin
      File_Writer.Write (State, File_Name);
   end Write;

   procedure New_Date (State : access Skill_State; date : v64) is
      New_Object : Date_Type_Access := new Date_Type'
        (date => date);
   begin
      State.Put_Object ("date", Skill_Type_Access (New_Object));
   end New_Date;

   function Get_Dates (State : access Skill_State) return Date_Type_Accesses is
      Length : Natural := State.Storage_Pool_Size ("date");
      rval : Date_Type_Accesses (1 .. Length);
   begin
      Ada.Text_IO.Put_Line ("length: " & Length'Img);
      for I in rval'Range loop
         rval (I) := Date_Type_Access (State.Get_Object ("date", I));
      end loop;
      return rval;
   end Get_Dates;

end Date.Api.Skill;

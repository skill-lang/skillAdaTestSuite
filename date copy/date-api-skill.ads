--  ___ _  ___ _ _                                                            --
-- / __| |/ (_) | |       Your SKilL Ada Binding                              --
-- \__ \ ' <| | | |__     <<debug>>                                           --
-- |___/_|\_\_|_|____|    by: <<some developer>>                              --
--                                                                            --

with Date.Internal.File_Reader;
with Date.Internal.File_Writer;

package Date.Api.Skill is

   type Date_Type_Accesses is array (Natural range <>) of Date_Type_Access;

   procedure Read (State : access Skill_State; File_Name : String);
   procedure Write (State : access Skill_State; File_Name : String);

   procedure New_Date (State : access Skill_State; date : v64);
   function Get_Dates (State : access Skill_State) return Date_Type_Accesses;

end Date.Api.Skill;

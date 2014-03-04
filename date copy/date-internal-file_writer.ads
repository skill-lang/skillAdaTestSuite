--  ___ _  ___ _ _                                                            --
-- / __| |/ (_) | |       Your SKilL Ada Binding                              --
-- \__ \ ' <| | | |__     <<debug>>                                           --
-- |___/_|\_\_|_|____|    by: <<some developer>>                              --
--                                                                            --

with Date.Internal.Byte_Writer;

package Date.Internal.File_Writer is

   procedure Write (pState : access Skill_State; File_Name : String);

private

   procedure Write_String_Pool;

end Date.Internal.File_Writer;

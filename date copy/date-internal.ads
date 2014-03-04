--  ___ _  ___ _ _                                                            --
-- / __| |/ (_) | |       Your SKilL Ada Binding                              --
-- \__ \ ' <| | | |__     <<debug>>                                           --
-- |___/_|\_\_|_|____|    by: <<some developer>>                              --
--                                                                            --

with Ada.Streams.Stream_IO;
with Interfaces;

package Date.Internal is

   package ASS_IO renames Ada.Streams.Stream_IO;

   subtype Byte is Interfaces.Unsigned_8;

end Date.Internal;

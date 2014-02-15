with Ada.Streams.Stream_IO;
with Interfaces;

package Date.Internal is

   package ASS_IO renames Ada.Streams.Stream_IO;

   subtype Byte is Interfaces.Unsigned_8;

end Date.Internal;
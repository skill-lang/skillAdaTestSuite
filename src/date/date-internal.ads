with Ada.Streams.Stream_IO;
with Ada.Strings.Unbounded;
with Interfaces;

package Date.Internal is

   package ASS_IO renames Ada.Streams.Stream_IO;
   package SU renames Ada.Strings.Unbounded;

   type String_Pool_Type is array (Long range <>) of SU.Unbounded_String;

   subtype Byte is Interfaces.Unsigned_8;

end Date.Internal;

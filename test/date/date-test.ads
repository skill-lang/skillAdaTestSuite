with Ada.Streams.Stream_IO;
with Date.Internal.Byte_Reader;
with Date.Internal.Byte_Writer;

package Date.Test is

   package ASS_IO renames Ada.Streams.Stream_IO;

   package Byte_Reader renames Date.Internal.Byte_Reader;
   package Byte_Writer renames Date.Internal.Byte_Writer;

end Date.Test;

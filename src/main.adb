with Ada.Text_IO;
with Date.Internal.Parsers.Byte_Reader;

procedure Main is
begin
   Date.Internal.Parsers.Byte_Reader.Read ("resources/date-example.sf");
   Date.Internal.Parsers.Byte_Reader.Write ("resources/ada.sf");
end Main;

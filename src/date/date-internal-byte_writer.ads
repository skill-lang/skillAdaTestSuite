with Ada.Unchecked_Conversion;
with Ada.Text_IO;

package Date.Internal.Byte_Writer is

   procedure Initialize (pOutput_Stream : ASS_IO.Stream_Access);

   procedure Write_i8 (Value : i8);
   procedure Write_i16 (Value : i16);
   procedure Write_i32 (Value : i32);
   procedure Write_i64 (Value : i64);

   procedure Write_v64 (Value : v64);

   procedure Write_f32 (Value : f32);
   procedure Write_f64 (Value : f64);

   procedure Write_String (Value : String);

private

   procedure Write_Byte (Next : Byte);

   type Byte_v64_Type is array (Natural range <>) of Byte;
   function Get_v64_Bytes (Value : v64) return Byte_v64_Type;

end Date.Internal.Byte_Writer;

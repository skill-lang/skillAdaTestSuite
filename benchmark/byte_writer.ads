--  ___ _  ___ _ _                                                            --
-- / __| |/ (_) | |       Your SKilL Ada Binding                              --
-- \__ \ ' <| | | |__     <<debug>>                                           --
-- |___/_|\_\_|_|____|    by: <<some developer>>                              --
--                                                                            --

with Ada.Streams.Stream_IO;
with Ada.Unchecked_Conversion;
with Interfaces;
with System.Machine_Code;

package Byte_Writer is

   package ASS_IO renames Ada.Streams.Stream_IO;
   type Byte is new Interfaces.Unsigned_8;

   type i8 is new Interfaces.Integer_8;
   type i16 is new Interfaces.Integer_16;
   subtype Short is i16;
   type i32 is new Interfaces.Integer_32;
   type i64 is new Interfaces.Integer_64;
   subtype v64 is i64;
   subtype Long is i64;
   type f32 is new Interfaces.IEEE_Float_32;
   type f64 is new Interfaces.IEEE_Float_64;

   procedure Finalize_Buffer (Stream : ASS_IO.Stream_Access);

   procedure Write_i8 (Stream : ASS_IO.Stream_Access; Value : i8);
   procedure Write_i16 (Stream : ASS_IO.Stream_Access; Value : i16);
   procedure Write_i32 (Stream : ASS_IO.Stream_Access; Value : i32);
   procedure Write_i64 (Stream : ASS_IO.Stream_Access; Value : i64);

   procedure Write_v64 (Stream : ASS_IO.Stream_Access; Value : v64);

   procedure Write_Boolean (Stream : ASS_IO.Stream_Access; Value : Boolean);
   procedure Write_String (Stream : ASS_IO.Stream_Access; Value : String);

private

   Buffer_Size : constant Positive := 2**16;
   Buffer_Index : Natural := 0;
   type Buffer is array (Positive range <>) of Byte;
   procedure Write_Buffer (Stream : not null access Ada.Streams.Root_Stream_Type'Class; Item : in Buffer);
   for Buffer'Write use Write_Buffer;
   Buffer_Array : Buffer (1 .. Buffer_Size);

   procedure Write_Byte (Stream : ASS_IO.Stream_Access; Next : Byte);

   pragma Inline (Finalize_Buffer, Write_i8, Write_i16, Write_i32, Write_i64, Write_v64, Write_Boolean, Write_String, Write_Buffer, Write_Byte);

end Byte_Writer;

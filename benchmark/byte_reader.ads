--  ___ _  ___ _ _                                                            --
-- / __| |/ (_) | |       Your SKilL Ada Binding                              --
-- \__ \ ' <| | | |__     <<debug>>                                           --
-- |___/_|\_\_|_|____|    by: <<some developer>>                              --
--                                                                            --

with Ada.Streams.Stream_IO;
with Ada.Unchecked_Conversion;
with Interfaces;

package Byte_Reader is

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

   procedure Reset_Buffer;
   function End_Of_Buffer return Boolean;

   function Read_i8 (Input_Stream : ASS_IO.Stream_Access) return i8;
   function Read_i16 (Input_Stream : ASS_IO.Stream_Access) return i16;
   function Read_i32 (Input_Stream : ASS_IO.Stream_Access) return i32;
   function Read_i64 (Input_Stream : ASS_IO.Stream_Access) return i64;

   function Read_v64 (Input_Stream : ASS_IO.Stream_Access) return v64;

   function Read_Boolean (Input_Stream : ASS_IO.Stream_Access) return Boolean;
   function Read_String (Input_Stream : ASS_IO.Stream_Access; Length : i32) return String;

   procedure Skip_Bytes (Input_Stream : ASS_IO.Stream_Access; Length : Long);

private

   Buffer_Size : constant Positive := 2**16;
   Buffer_Last : Positive;
   Buffer_Index : Integer := Buffer_Size;
   type Buffer is array (Positive range <>) of Byte;
   procedure Read_Buffer (Stream : not null access Ada.Streams.Root_Stream_Type'Class; Item : out Buffer);
   for Buffer'Read use Read_Buffer;
   Buffer_Array : Buffer (1 .. Buffer_Size);

   function Read_Byte (Input_Stream : ASS_IO.Stream_Access) return Byte;

   pragma Inline (Reset_Buffer, End_Of_Buffer, Read_i8, Read_i16, Read_i32, Read_i64, Read_v64, Read_Boolean, Read_String, Skip_Bytes, Read_Buffer, Read_Byte);

end Byte_Reader;

with Ada.Streams.Stream_IO;
with Interfaces;

package Benchmark_V64 is

   package ASS_IO renames Ada.Streams.Stream_IO;

   subtype Long is Long_Integer;

   procedure Write (N : Long; File_Name : String);
   procedure Read (N : Long; File_Name : String);

end Benchmark_V64;

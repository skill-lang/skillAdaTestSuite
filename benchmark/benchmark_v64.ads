with Ada.Streams.Stream_IO;

package Benchmark_V64 is

   subtype Long is Long_Integer;

   package ASS_IO renames Ada.Streams.Stream_IO;

   procedure Write (N : Long; File_Name : String);
   procedure Read (N : Long; File_Name : String);

end Benchmark_V64;

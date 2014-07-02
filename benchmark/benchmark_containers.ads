with Ada.Containers.Indefinite_Vectors;
with Ada.Containers.Vectors;

package Benchmark_Containers is

   subtype Long is Long_Integer;

   procedure Test_Indefinite (N : Long; File_Name : String);
   procedure Test_Non_Indefinite (N : Long; File_Name : String);

end Benchmark_Containers;

package Benchmark_Number is

   subtype Long is Long_Integer;

   procedure Create (N : Long; File_Name : String);
   procedure Write (N : Long; File_Name : String);
   procedure Read (N : Long; File_Name : String);

end Benchmark_Number;

package Benchmark_Graph_2 is

   subtype Long is Long_Integer;

   procedure Create (N : Integer; File_Name : String);
   procedure Write (N : Integer; File_Name : String);
   procedure Read (N : Integer; File_Name : String);
   procedure Create_More (N : Integer; File_Name : String);
   procedure Append (N : Integer; File_Name : String);
   procedure Reset (N : Integer; File_Name : String);

end Benchmark_Graph_2;

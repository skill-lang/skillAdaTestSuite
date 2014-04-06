package Benchmark_Date is

   subtype Long is Long_Integer;

   procedure Create (N : Long; File_Name : String);
   procedure Write (N : Long; File_Name : String);
   procedure Read (N : Long; File_Name : String);
   procedure Create_More (N : Long; File_Name : String);
   procedure Append (N : Long; File_Name : String);
   procedure Reset (N : Long; File_Name : String);

end Benchmark_Date;

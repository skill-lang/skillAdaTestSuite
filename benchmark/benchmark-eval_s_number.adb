with Benchmark_S_Number;

separate (Benchmark)

procedure Eval_S_Number (Count, Repetitions : Natural) is
   Base_Name : constant String := "s-number";
begin
   for J in 0 .. Repetitions loop
      for I in 1 .. Count loop
         Measure (Base_Name, Integer (10 ** I * 0.25), J, "create", Benchmark_S_Number.Create'Access);
         Measure (Base_Name, Integer (10 ** I * 0.25), J, "write", Benchmark_S_Number.Write'Access);
         Measure (Base_Name, Integer (10 ** I * 0.25), J, "reset", Benchmark_S_Number.Reset'Access);
         Measure (Base_Name, Integer (10 ** I * 0.25), J, "read", Benchmark_S_Number.Read'Access);

         Measure (Base_Name, Integer (10 ** I * 0.50), J, "create", Benchmark_S_Number.Create'Access);
         Measure (Base_Name, Integer (10 ** I * 0.50), J, "write", Benchmark_S_Number.Write'Access);
         Measure (Base_Name, Integer (10 ** I * 0.50), J, "reset", Benchmark_S_Number.Reset'Access);
         Measure (Base_Name, Integer (10 ** I * 0.50), J, "read", Benchmark_S_Number.Read'Access);

         Measure (Base_Name, Integer (10 ** I * 0.75), J, "create", Benchmark_S_Number.Create'Access);
         Measure (Base_Name, Integer (10 ** I * 0.75), J, "write", Benchmark_S_Number.Write'Access);
         Measure (Base_Name, Integer (10 ** I * 0.75), J, "reset", Benchmark_S_Number.Reset'Access);
         Measure (Base_Name, Integer (10 ** I * 0.75), J, "read", Benchmark_S_Number.Read'Access);

         Measure (Base_Name, Integer (10 ** I * 1.00), J, "create", Benchmark_S_Number.Create'Access);
         Measure (Base_Name, Integer (10 ** I * 1.00), J, "write", Benchmark_S_Number.Write'Access);
         Measure (Base_Name, Integer (10 ** I * 1.00), J, "reset", Benchmark_S_Number.Reset'Access);
         Measure (Base_Name, Integer (10 ** I * 1.00), J, "read", Benchmark_S_Number.Read'Access);
      end loop;
   end loop;

   declare
      Function_Name : constant String := "create";
      Print_Type : constant String := "time";
   begin
      Ada.Text_IO.Put_Line ("\addplot+[smooth,color=blue,mark=star,mark options={fill=white}] coordinates { % ada " & Base_Name & " " & Function_Name & " " & Print_Type);
      Print (Base_Name, Repetitions, Function_Name, Print_TIME);
      Ada.Text_IO.Put_Line ("};");
   end;

   declare
      Function_Name : constant String := "write";
      Print_Type : constant String := "time";
   begin
      Ada.Text_IO.Put_Line ("\addplot+[smooth,color=black,mark=star,mark options={fill=white}] coordinates { % ada " & Base_Name & " " & Function_Name & " " & Print_Type);
      Print (Base_Name, Repetitions, Function_Name, Print_TIME);
      Ada.Text_IO.Put_Line ("};");
   end;

   declare
      Function_Name : constant String := "read";
      Print_Type : constant String := "time";
   begin
      Ada.Text_IO.Put_Line ("\addplot+[smooth,color=red,mark=star,mark options={fill=white}] coordinates { % ada " & Base_Name & " " & Function_Name & " " & Print_Type);
      Print (Base_Name, Repetitions, Function_Name, Print_TIME);
      Ada.Text_IO.Put_Line ("};");
   end;

   Ada.Text_IO.New_Line;

   declare
      Function_Name : constant String := "write";
      Print_Type : constant String := "size";
   begin
      Ada.Text_IO.Put_Line ("\addplot+[smooth,color=black,mark=star,mark options={fill=white}] coordinates { % ada " & Base_Name & " " & Function_Name & " " & Print_Type);
      Print (Base_Name, Repetitions, Function_Name, Print_SIZE);
      Ada.Text_IO.Put_Line ("};");
   end;

   Ada.Text_IO.New_Line;

   declare
      Function_Name : constant String := "write";
      Print_Type : constant String := "throughput";
   begin
      Ada.Text_IO.Put_Line ("\addplot+[smooth,color=black,mark=star,mark options={fill=white}] coordinates { % ada " & Base_Name & " " & Function_Name & " " & Print_Type);
      Print (Base_Name, Repetitions, Function_Name, Print_THROUGHPUT);
      Ada.Text_IO.Put_Line ("};");
   end;

   declare
      Function_Name : constant String := "read";
      Print_Type : constant String := "throughput";
   begin
      Ada.Text_IO.Put_Line ("\addplot+[smooth,color=red,mark=star,mark options={fill=white}] coordinates { % ada " & Base_Name & " " & Function_Name & " " & Print_Type);
      Print (Base_Name, Repetitions, Function_Name, Print_THROUGHPUT);
      Ada.Text_IO.Put_Line ("};");
   end;
end Eval_S_Number;

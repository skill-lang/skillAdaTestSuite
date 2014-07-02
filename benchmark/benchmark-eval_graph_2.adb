with Benchmark_Graph_2;

separate (Benchmark)

procedure Eval_Graph_2 (Count, Repetitions : Natural) is
   Base_Name : constant String := "graph-2";
begin
   for J in 0 .. Repetitions loop
      for I in 1 .. Count loop
         Measure (Base_Name, Integer (10 ** I * 0.25), J, "create", Benchmark_Graph_2.Create'Access);
         Measure (Base_Name, Integer (10 ** I * 0.25), J, "write", Benchmark_Graph_2.Write'Access);
         Measure (Base_Name, Integer (10 ** I * 0.25), J, "reset", Benchmark_Graph_2.Reset'Access);
         Measure (Base_Name, Integer (10 ** I * 0.25), J, "read", Benchmark_Graph_2.Read'Access);
         Measure (Base_Name, Integer (10 ** I * 0.25), J, "create-more", Benchmark_Graph_2.Create_More'Access);
         Measure (Base_Name, Integer (10 ** I * 0.25), J, "append", Benchmark_Graph_2.Append'Access);
         Measure (Base_Name, Integer (10 ** I * 0.25), J, "reset", Benchmark_Graph_2.Reset'Access);

         if 7 > I then
         Measure (Base_Name, Integer (10 ** I * 0.50), J, "create", Benchmark_Graph_2.Create'Access);
         Measure (Base_Name, Integer (10 ** I * 0.50), J, "write", Benchmark_Graph_2.Write'Access);
         Measure (Base_Name, Integer (10 ** I * 0.50), J, "reset", Benchmark_Graph_2.Reset'Access);
         Measure (Base_Name, Integer (10 ** I * 0.50), J, "read", Benchmark_Graph_2.Read'Access);
         Measure (Base_Name, Integer (10 ** I * 0.50), J, "create-more", Benchmark_Graph_2.Create_More'Access);
         Measure (Base_Name, Integer (10 ** I * 0.50), J, "append", Benchmark_Graph_2.Append'Access);
         Measure (Base_Name, Integer (10 ** I * 0.50), J, "reset", Benchmark_Graph_2.Reset'Access);

         Measure (Base_Name, Integer (10 ** I * 0.75), J, "create", Benchmark_Graph_2.Create'Access);
         Measure (Base_Name, Integer (10 ** I * 0.75), J, "write", Benchmark_Graph_2.Write'Access);
         Measure (Base_Name, Integer (10 ** I * 0.75), J, "reset", Benchmark_Graph_2.Reset'Access);
         Measure (Base_Name, Integer (10 ** I * 0.75), J, "read", Benchmark_Graph_2.Read'Access);
         Measure (Base_Name, Integer (10 ** I * 0.75), J, "create-more", Benchmark_Graph_2.Create_More'Access);
         Measure (Base_Name, Integer (10 ** I * 0.75), J, "append", Benchmark_Graph_2.Append'Access);
         Measure (Base_Name, Integer (10 ** I * 0.75), J, "reset", Benchmark_Graph_2.Reset'Access);

         Measure (Base_Name, Integer (10 ** I * 1.00), J, "create", Benchmark_Graph_2.Create'Access);
         Measure (Base_Name, Integer (10 ** I * 1.00), J, "write", Benchmark_Graph_2.Write'Access);
         Measure (Base_Name, Integer (10 ** I * 1.00), J, "reset", Benchmark_Graph_2.Reset'Access);
         Measure (Base_Name, Integer (10 ** I * 1.00), J, "read", Benchmark_Graph_2.Read'Access);
         Measure (Base_Name, Integer (10 ** I * 1.00), J, "create-more", Benchmark_Graph_2.Create_More'Access);
         Measure (Base_Name, Integer (10 ** I * 1.00), J, "append", Benchmark_Graph_2.Append'Access);
         Measure (Base_Name, Integer (10 ** I * 1.00), J, "reset", Benchmark_Graph_2.Reset'Access);
         end if;
      end loop;
   end loop;

   Correct_Append_Size (Base_Name);

   declare
      Function_Name : constant String := "create";
      Print_Type : constant String := "time";
   begin
      Ada.Text_IO.Put_Line ("\addplot+[smooth,color=blue,mark=square*,mark options={fill=white}] coordinates { % ada " & Base_Name & " " & Function_Name & " " & Print_Type);
      Print (Base_Name, Repetitions, Function_Name, Print_TIME);
      Ada.Text_IO.Put_Line ("};");
   end;

   declare
      Function_Name : constant String := "write";
      Print_Type : constant String := "time";
   begin
      Ada.Text_IO.Put_Line ("\addplot+[smooth,color=black,mark=square*,mark options={fill=white}] coordinates { % ada " & Base_Name & " " & Function_Name & " " & Print_Type);
      Print (Base_Name, Repetitions, Function_Name, Print_TIME);
      Ada.Text_IO.Put_Line ("};");
   end;

   declare
      Function_Name : constant String := "read";
      Print_Type : constant String := "time";
   begin
      Ada.Text_IO.Put_Line ("\addplot+[smooth,color=red,mark=square*,mark options={fill=white}] coordinates { % ada " & Base_Name & " " & Function_Name & " " & Print_Type);
      Print (Base_Name, Repetitions, Function_Name, Print_TIME);
      Ada.Text_IO.Put_Line ("};");
   end;

   declare
      Function_Name : constant String := "create-more";
      Print_Type : constant String := "time";
   begin
      Ada.Text_IO.Put_Line ("\addplot+[smooth,color=orange,mark=square*,mark options={fill=white}] coordinates { % ada " & Base_Name & " " & Function_Name & " " & Print_Type);
      Print (Base_Name, Repetitions, Function_Name, Print_TIME);
      Ada.Text_IO.Put_Line ("};");
   end;

   declare
      Function_Name : constant String := "append";
      Print_Type : constant String := "time";
   begin
      Ada.Text_IO.Put_Line ("\addplot+[smooth,color=teal,mark=square*,mark options={fill=white}] coordinates { % ada " & Base_Name & " " & Function_Name & " " & Print_Type);
      Print (Base_Name, Repetitions, Function_Name, Print_TIME);
      Ada.Text_IO.Put_Line ("};");
   end;

   Ada.Text_IO.New_Line;

   declare
      Function_Name : constant String := "write";
      Print_Type : constant String := "size";
   begin
      Ada.Text_IO.Put_Line ("\addplot+[smooth,color=black,mark=square*,mark options={fill=white}] coordinates { % ada " & Base_Name & " " & Function_Name & " " & Print_Type);
      Print (Base_Name, Repetitions, Function_Name, Print_SIZE);
      Ada.Text_IO.Put_Line ("};");
   end;

   declare
      Function_Name : constant String := "append";
      Print_Type : constant String := "size";
   begin
      Ada.Text_IO.Put_Line ("\addplot+[smooth,color=teal,mark=square*,mark options={fill=white}] coordinates { % ada " & Base_Name & " " & Function_Name & " " & Print_Type);
      Print (Base_Name, Repetitions, Function_Name, Print_SIZE);
      Ada.Text_IO.Put_Line ("};");
   end;

   Ada.Text_IO.New_Line;

   declare
      Function_Name : constant String := "write";
      Print_Type : constant String := "throughput";
   begin
      Ada.Text_IO.Put_Line ("\addplot+[smooth,color=black,mark=square*,mark options={fill=white}] coordinates { % ada " & Base_Name & " " & Function_Name & " " & Print_Type);
      Print (Base_Name, Repetitions, Function_Name, Print_THROUGHPUT);
      Ada.Text_IO.Put_Line ("};");
   end;

   declare
      Function_Name : constant String := "read";
      Print_Type : constant String := "throughput";
   begin
      Ada.Text_IO.Put_Line ("\addplot+[smooth,color=red,mark=square*,mark options={fill=white}] coordinates { % ada " & Base_Name & " " & Function_Name & " " & Print_Type);
      Print (Base_Name, Repetitions, Function_Name, Print_THROUGHPUT);
      Ada.Text_IO.Put_Line ("};");
   end;

   declare
      Function_Name : constant String := "append";
      Print_Type : constant String := "throughput";
   begin
      Ada.Text_IO.Put_Line ("\addplot+[smooth,color=teal,mark=square*,mark options={fill=white}] coordinates { % ada " & Base_Name & " " & Function_Name & " " & Print_Type);
      Print (Base_Name, Repetitions, Function_Name, Print_THROUGHPUT);
      Ada.Text_IO.Put_Line ("};");
   end;
end Eval_Graph_2;

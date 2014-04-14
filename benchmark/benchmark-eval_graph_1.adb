with Benchmark_Graph_1;

separate (Benchmark)

procedure Eval_Graph_1 (Count, Repetitions : Natural) is
   Base_Name : constant String := "graph-1";
begin
   for J in 0 .. Repetitions loop
      for I in 1 .. Count loop
         declare
            package X is new Benchmark_Graph_1;
         begin
            Measure (Base_Name, Integer (10 ** I * 0.25), J, "create", X.Create'Access);
            Measure (Base_Name, Integer (10 ** I * 0.25), J, "write", X.Write'Access);
            Measure (Base_Name, Integer (10 ** I * 0.25), J, "reset", X.Reset'Access);
            Measure (Base_Name, Integer (10 ** I * 0.25), J, "read", X.Read'Access);
            Measure (Base_Name, Integer (10 ** I * 0.25), J, "create-more", X.Create_More'Access);
            Measure (Base_Name, Integer (10 ** I * 0.25), J, "append", X.Append'Access);
            Measure (Base_Name, Integer (10 ** I * 0.25), J, "reset", X.Reset'Access);
         end;

         declare
            package X is new Benchmark_Graph_1;
         begin
            Measure (Base_Name, Integer (10 ** I * 0.50), J, "create", X.Create'Access);
            Measure (Base_Name, Integer (10 ** I * 0.50), J, "write", X.Write'Access);
            Measure (Base_Name, Integer (10 ** I * 0.50), J, "reset", X.Reset'Access);
            Measure (Base_Name, Integer (10 ** I * 0.50), J, "read", X.Read'Access);
            Measure (Base_Name, Integer (10 ** I * 0.50), J, "create-more", X.Create_More'Access);
            Measure (Base_Name, Integer (10 ** I * 0.50), J, "append", X.Append'Access);
            Measure (Base_Name, Integer (10 ** I * 0.50), J, "reset", X.Reset'Access);
         end;

         declare
            package X is new Benchmark_Graph_1;
         begin
            Measure (Base_Name, Integer (10 ** I * 0.75), J, "create", X.Create'Access);
            Measure (Base_Name, Integer (10 ** I * 0.75), J, "write", X.Write'Access);
            Measure (Base_Name, Integer (10 ** I * 0.75), J, "reset", X.Reset'Access);
            Measure (Base_Name, Integer (10 ** I * 0.75), J, "read", X.Read'Access);
            Measure (Base_Name, Integer (10 ** I * 0.75), J, "create-more", X.Create_More'Access);
            Measure (Base_Name, Integer (10 ** I * 0.75), J, "append", X.Append'Access);
            Measure (Base_Name, Integer (10 ** I * 0.75), J, "reset", X.Reset'Access);
         end;

         declare
            package X is new Benchmark_Graph_1;
         begin
            Measure (Base_Name, Integer (10 ** I * 1.00), J, "create", X.Create'Access);
            Measure (Base_Name, Integer (10 ** I * 1.00), J, "write", X.Write'Access);
            Measure (Base_Name, Integer (10 ** I * 1.00), J, "reset", X.Reset'Access);
            Measure (Base_Name, Integer (10 ** I * 1.00), J, "read", X.Read'Access);
            Measure (Base_Name, Integer (10 ** I * 1.00), J, "create-more", X.Create_More'Access);
            Measure (Base_Name, Integer (10 ** I * 1.00), J, "append", X.Append'Access);
            Measure (Base_Name, Integer (10 ** I * 1.00), J, "reset", X.Reset'Access);
         end;
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
end Eval_Graph_1;

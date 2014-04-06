with Ada.Calendar;
with Ada.Containers.Indefinite_Hashed_Maps;
with Ada.Containers.Indefinite_Vectors;
with Ada.Directories;
with Ada.Strings.Fixed;
with Ada.Strings.Hash;
with Ada.Text_IO;

with Benchmark_I64;
with Benchmark_V64;
with Benchmark_Containers;

with Benchmark_Number;
with Benchmark_Date;
with Benchmark_Graph_1;

procedure Benchmark is

   subtype Long is Long_Integer;

   use Ada.Calendar;
   use Ada.Directories;
   use Ada.Strings.Fixed;

   package Results_Vector is new Ada.Containers.Indefinite_Vectors (Positive, String);
   type Results_Vector_Access is access Results_Vector.Vector;
   package Results_Hash_Map is new Ada.Containers.Indefinite_Hashed_Maps (String, Results_Vector_Access, Ada.Strings.Hash, "=");
   type Results_Hash_Map_Access is access Results_Hash_Map.Map;

   Results_HM : Results_Hash_Map_Access := new Results_Hash_Map.Map;

   function Get_String (N : Long; S : String) return String is
      ("(" & Trim (N'Img, Ada.Strings.Left) & ", " & S & ")");

   procedure Push (Name : String; N : Long; Size : Long; Time : Duration) is
   begin
      --  time
      declare
         id : constant String := Name & "-time";
         X : Duration := Time;
         S : String := Trim (X'Img, Ada.Strings.Left);
      begin
         if not Results_HM.Contains (id) then
            Results_HM.Insert (id, new Results_Vector.Vector);
         end if;
         Results_HM.Element (id).Append (Get_String (N, S));
      end;

      --  size
      declare
         id : constant String := Name & "-size";
         X : Duration := Duration (Size) / Duration (N);  --  size / instance
         S : String := Trim (X'Img, Ada.Strings.Left);
      begin
         if not Results_HM.Contains (id) then
            Results_HM.Insert (id, new Results_Vector.Vector);
         end if;
         Results_HM.Element (id).Append (Get_String (N, S));
      end;

      --  throughput
      declare
         id : constant String := Name & "-throughput";
         X : Duration := (Duration (Size) / (1024**2)) / Time;  --  site / time
         S : String := Trim (X'Img, Ada.Strings.Left);
      begin
         if not Results_HM.Contains (id) then
            Results_HM.Insert (id, new Results_Vector.Vector);
         end if;
         Results_HM.Element (id).Append (Get_String (N, S));
      end;

   end Push;

   procedure Measure (Function_Name : String; Repetitions : Natural; Test : access procedure (N : Long; File_Name : String); Base_Name : String; Base_File_Name : String; N : Long) is
      function Calculate (Start : Ada.Calendar.Time) return Duration is
         (Clock - Start);
      pragma Inline (Calculate);

      File_Name : constant String := Base_File_Name & "-n" & Trim (N'Img, Ada.Strings.Left) & "-r" & Trim (Repetitions'Img, Ada.Strings.Left);

      Total_Size : Long := 0;
      Total_Time : Duration := 0.0;

      Write_Total_Size : Long := 0;

      Number : Long := N;
   begin
      for I in 0 .. Repetitions loop
         Ada.Text_IO.Put_Line ("--> " & Base_Name & " " & Function_Name & " ;; N: " & Trim (N'Img, Ada.Strings.Left) & " W: " & Trim (I'Img, Ada.Strings.Left));
         declare
            Start : Time := Clock;
         begin
            Test (N, File_Name);

            declare
               Measured : Duration := Calculate (Start);
            begin
               if "write" = Function_Name or else "read" = Function_Name or else "append" = Function_Name then
                  Total_Size := Total_Size + Long (Size (File_Name));

                  if "append" /= Function_Name then
                     Write_Total_Size := Write_Total_Size + Total_Size;
                  end if;
               end if;

               Total_Time := Total_Time + Measured;
            end;
         end;
      end loop;

      if "write" = Function_Name or else "read" = Function_Name then
         Total_Size := Total_Size / Long (1 + Repetitions);
      end if;

      if "append" = Function_Name then
         Total_Size := (Total_Size - Write_Total_Size) / Long (1 + Repetitions);
      end if;

      Total_Time := Total_Time / (1 + Repetitions);

      Push (Base_Name & "-" & Function_Name, Number, Total_Size, Total_Time);
   end Measure;

   procedure Iterate (Position : Results_Vector.Cursor) is
      S : String := Results_Vector.Element (Position);
   begin
      Ada.Text_IO.Put (S & " ");
   end;
   pragma Inline (Iterate);

   procedure Print (Base_Name : String) is
   begin
      declare
         Name : constant String := Base_Name & "-create-time";
      begin
         if Results_HM.Contains (Name) then
            Ada.Text_IO.Put_Line ("\addplot+[smooth,color=blue,mark=square*,mark options={fill=white}] coordinates { % ada " & Name);
            Results_HM.Element (Name).Iterate (Iterate'Access);
            Ada.Text_IO.New_Line;
            Ada.Text_IO.Put_Line ("};");
         else
            Ada.Text_IO.Put_Line ("% " & Name & " nicht vorhanden!");
         end if;
      end;

      declare
         Name : constant String := Base_Name & "-read-time";
      begin
         if Results_HM.Contains (Name) then
            Ada.Text_IO.Put_Line ("\addplot+[smooth,color=red,mark=square*,mark options={fill=white}] coordinates { % ada " & Name);
            Results_HM.Element (Name).Iterate (Iterate'Access);
            Ada.Text_IO.New_Line;
            Ada.Text_IO.Put_Line ("};");
         else
            Ada.Text_IO.Put_Line ("% " & Name & " nicht vorhanden!");
         end if;
      end;

      declare
         Name : constant String := Base_Name & "-write-time";
      begin
         if Results_HM.Contains (Name) then
            Ada.Text_IO.Put_Line ("\addplot+[smooth,color=black,mark=square*,mark options={fill=white}] coordinates { % ada " & Name);
            Results_HM.Element (Name).Iterate (Iterate'Access);
            Ada.Text_IO.New_Line;
            Ada.Text_IO.Put_Line ("};");
         else
            Ada.Text_IO.Put_Line ("% " & Name & " nicht vorhanden!");
         end if;
      end;

      declare
         Name : constant String := Base_Name & "-create-more-time";
      begin
         if Results_HM.Contains (Name) then
            Ada.Text_IO.Put_Line ("\addplot+[smooth,color=black,mark=square*,mark options={fill=white}] coordinates { % ada " & Name);
            Results_HM.Element (Name).Iterate (Iterate'Access);
            Ada.Text_IO.New_Line;
            Ada.Text_IO.Put_Line ("};");
         else
            Ada.Text_IO.Put_Line ("% " & Name & " nicht vorhanden!");
         end if;
      end;

      declare
         Name : constant String := Base_Name & "-append-time";
      begin
         if Results_HM.Contains (Name) then
            Ada.Text_IO.Put_Line ("\addplot+[smooth,color=black,mark=square*,mark options={fill=white}] coordinates { % ada " & Name);
            Results_HM.Element (Name).Iterate (Iterate'Access);
            Ada.Text_IO.New_Line;
            Ada.Text_IO.Put_Line ("};");
         else
            Ada.Text_IO.Put_Line ("% " & Name & " nicht vorhanden!");
         end if;
      end;

      declare
         Name : constant String := Base_Name & "-write-size";
      begin
         if Results_HM.Contains (Name) then
            Ada.Text_IO.Put_Line ("\addplot+[smooth,color=red,mark=square*,mark options={fill=white}] coordinates { % ada " & Name);
            Results_HM.Element (Name).Iterate (Iterate'Access);
            Ada.Text_IO.New_Line;
            Ada.Text_IO.Put_Line ("};");
         else
            Ada.Text_IO.Put_Line ("% " & Name & " nicht vorhanden!");
         end if;
      end;

      declare
         Name : constant String := Base_Name & "-append-size";
      begin
         if Results_HM.Contains (Name) then
            Ada.Text_IO.Put_Line ("\addplot+[smooth,color=red,mark=square*,mark options={fill=white}] coordinates { % ada " & Name);
            Results_HM.Element (Name).Iterate (Iterate'Access);
            Ada.Text_IO.New_Line;
            Ada.Text_IO.Put_Line ("};");
         else
            Ada.Text_IO.Put_Line ("% " & Name & " nicht vorhanden!");
         end if;
      end;

      declare
         Name : constant String := Base_Name & "-read-throughput";
      begin
         if Results_HM.Contains (Name) then
            Ada.Text_IO.Put_Line ("\addplot+[smooth,color=red,mark=square*,mark options={fill=white}] coordinates { % ada " & Name);
            Results_HM.Element (Name).Iterate (Iterate'Access);
            Ada.Text_IO.New_Line;
            Ada.Text_IO.Put_Line ("};");
         else
            Ada.Text_IO.Put_Line ("% " & Name & " nicht vorhanden!");
         end if;
      end;

      declare
         Name : constant String := Base_Name & "-write-throughput";
      begin
         if Results_HM.Contains (Name) then
            Ada.Text_IO.Put_Line ("\addplot+[smooth,color=black,mark=square*,mark options={fill=white}] coordinates { % ada " & Name);
            Results_HM.Element (Name).Iterate (Iterate'Access);
            Ada.Text_IO.New_Line;
            Ada.Text_IO.Put_Line ("};");
         else
            Ada.Text_IO.Put_Line ("% " & Name & " nicht vorhanden!");
         end if;
      end;

      declare
         Name : constant String := Base_Name & "-append-throughput";
      begin
         if Results_HM.Contains (Name) then
            Ada.Text_IO.Put_Line ("\addplot+[smooth,color=black,mark=square*,mark options={fill=white}] coordinates { % ada " & Name);
            Results_HM.Element (Name).Iterate (Iterate'Access);
            Ada.Text_IO.New_Line;
            Ada.Text_IO.Put_Line ("};");
         else
            Ada.Text_IO.Put_Line ("% " & Name & " nicht vorhanden!");
         end if;
      end;
   end Print;

   procedure Eval_I64 (Count, Repetitions : Natural) is
      Base_Name : constant String := "i64";
      Base_File_Name : constant String := "tmp/benchmark-" & Base_Name;
   begin
      for I in 1 .. Count loop
         Measure ("write", Repetitions, Benchmark_I64.Write'Access, Base_Name, Base_File_Name, Long (10 ** I * 0.25));
         Measure ("write", Repetitions, Benchmark_I64.Write'Access, Base_Name, Base_File_Name, Long (10 ** I * 0.50));
         Measure ("write", Repetitions, Benchmark_I64.Write'Access, Base_Name, Base_File_Name, Long (10 ** I * 0.75));
         Measure ("write", Repetitions, Benchmark_I64.Write'Access, Base_Name, Base_File_Name, Long (10 ** I * 1.00));
      end loop;

      for I in 1 .. Count loop
         Measure ("read", Repetitions, Benchmark_I64.Read'Access, Base_Name, Base_File_Name, Long (10 ** I * 0.25));
         Measure ("read", Repetitions, Benchmark_I64.Read'Access, Base_Name, Base_File_Name, Long (10 ** I * 0.50));
         Measure ("read", Repetitions, Benchmark_I64.Read'Access, Base_Name, Base_File_Name, Long (10 ** I * 0.75));
         Measure ("read", Repetitions, Benchmark_I64.Read'Access, Base_Name, Base_File_Name, Long (10 ** I * 1.00));
      end loop;

      Print (Base_Name);
      Results_HM.Clear;
   end Eval_I64;

   procedure Eval_V64 (Count, Repetitions : Natural) is
      Base_Name : constant String := "v64";
      Base_File_Name : constant String := "tmp/benchmark-" & Base_Name;
   begin
      for I in 1 .. Count loop
         Measure ("write", Repetitions, Benchmark_V64.Write'Access, Base_Name, Base_File_Name, Long (10 ** I * 0.25));
         Measure ("write", Repetitions, Benchmark_V64.Write'Access, Base_Name, Base_File_Name, Long (10 ** I * 0.50));
         Measure ("write", Repetitions, Benchmark_V64.Write'Access, Base_Name, Base_File_Name, Long (10 ** I * 0.75));
         Measure ("write", Repetitions, Benchmark_V64.Write'Access, Base_Name, Base_File_Name, Long (10 ** I * 1.00));
      end loop;

      for I in 1 .. Count loop
         Measure ("read", Repetitions, Benchmark_V64.Read'Access, Base_Name, Base_File_Name, Long (10 ** I * 0.25));
         Measure ("read", Repetitions, Benchmark_V64.Read'Access, Base_Name, Base_File_Name, Long (10 ** I * 0.50));
         Measure ("read", Repetitions, Benchmark_V64.Read'Access, Base_Name, Base_File_Name, Long (10 ** I * 0.75));
         Measure ("read", Repetitions, Benchmark_V64.Read'Access, Base_Name, Base_File_Name, Long (10 ** I * 1.00));
      end loop;

      Print (Base_Name);
      Results_HM.Clear;
   end Eval_V64;

   procedure Eval_Write_V64 (Count, Repetitions : Natural) is
      Base_Name : constant String := "write-v64";
      Base_File_Name : constant String := "tmp/benchmark-" & Base_Name;
   begin
      for I in 1 .. Count loop
         Measure ("write", Repetitions, Benchmark_V64.Write'Access, Base_Name, Base_File_Name, Long (10 ** I * 0.25));
         Measure ("write", Repetitions, Benchmark_V64.Write'Access, Base_Name, Base_File_Name, Long (10 ** I * 0.50));
         Measure ("write", Repetitions, Benchmark_V64.Write'Access, Base_Name, Base_File_Name, Long (10 ** I * 0.75));
         Measure ("write", Repetitions, Benchmark_V64.Write'Access, Base_Name, Base_File_Name, Long (10 ** I * 1.00));
      end loop;

      Print (Base_Name);
      Results_HM.Clear;
   end Eval_Write_V64;

   procedure Eval_Containers (Count, Repetitions : Natural) is
      Base_Name : constant String := "containers";
      Base_File_Name : constant String := "";
   begin
      for I in 1 .. Count loop
         Measure ("indefinite", Repetitions, Benchmark_Containers.Test_Indefinite'Access, Base_Name, Base_File_Name, Long (10 ** I * 0.25));
         Measure ("indefinite", Repetitions, Benchmark_Containers.Test_Indefinite'Access, Base_Name, Base_File_Name, Long (10 ** I * 0.50));
         Measure ("indefinite", Repetitions, Benchmark_Containers.Test_Indefinite'Access, Base_Name, Base_File_Name, Long (10 ** I * 0.75));
         Measure ("indefinite", Repetitions, Benchmark_Containers.Test_Indefinite'Access, Base_Name, Base_File_Name, Long (10 ** I * 1.00));
         Measure ("non-indefinite", Repetitions, Benchmark_Containers.Test_Non_Indefinite'Access, Base_Name, Base_File_Name, Long (10 ** I * 0.25));
         Measure ("non-indefinite", Repetitions, Benchmark_Containers.Test_Non_Indefinite'Access, Base_Name, Base_File_Name, Long (10 ** I * 0.50));
         Measure ("non-indefinite", Repetitions, Benchmark_Containers.Test_Non_Indefinite'Access, Base_Name, Base_File_Name, Long (10 ** I * 0.75));
         Measure ("non-indefinite", Repetitions, Benchmark_Containers.Test_Non_Indefinite'Access, Base_Name, Base_File_Name, Long (10 ** I * 1.00));
      end loop;

      declare
         Name : constant String := "containers-indefinite-time";
      begin
         if Results_HM.Contains (Name) then
            Ada.Text_IO.Put_Line ("\addplot+[smooth,color=red,mark=square*,mark options={fill=white}] coordinates { % ada " & Name);
            Results_HM.Element (Name).Iterate (Iterate'Access);
            Ada.Text_IO.New_Line;
            Ada.Text_IO.Put_Line ("};");
         else
            Ada.Text_IO.Put_Line ("% " & Name & " nicht vorhanden!");
         end if;
      end;

      declare
         Name : constant String := "containers-non-indefinite-time";
      begin
         if Results_HM.Contains (Name) then
            Ada.Text_IO.Put_Line ("\addplot+[smooth,color=black,mark=star,mark options={fill=white}] coordinates { % ada " & Name);
            Results_HM.Element (Name).Iterate (Iterate'Access);
            Ada.Text_IO.New_Line;
            Ada.Text_IO.Put_Line ("};");
         else
            Ada.Text_IO.Put_Line ("% " & Name & " nicht vorhanden!");
         end if;
      end;
   end Eval_Containers;

   procedure Eval_Number (Count, Repetitions : Natural) is
      Base_Name : constant String := "number";
      Base_File_Name : constant String := "tmp/benchmark-" & Base_Name;
   begin
      for I in 1 .. Count loop
         Measure ("create", Repetitions, Benchmark_Number.Create'Access, Base_Name, Base_File_Name, Long (10 ** I * 0.25));
         Measure ("write",  Repetitions, Benchmark_Number.Write'Access,  Base_Name, Base_File_Name, Long (10 ** I * 0.25));
         Measure ("create", Repetitions, Benchmark_Number.Create'Access, Base_Name, Base_File_Name, Long (10 ** I * 0.50));
         Measure ("write",  Repetitions, Benchmark_Number.Write'Access,  Base_Name, Base_File_Name, Long (10 ** I * 0.50));
         Measure ("create", Repetitions, Benchmark_Number.Create'Access, Base_Name, Base_File_Name, Long (10 ** I * 0.75));
         Measure ("write",  Repetitions, Benchmark_Number.Write'Access,  Base_Name, Base_File_Name, Long (10 ** I * 0.75));
         Measure ("create", Repetitions, Benchmark_Number.Create'Access, Base_Name, Base_File_Name, Long (10 ** I * 1.00));
         Measure ("write",  Repetitions, Benchmark_Number.Write'Access,  Base_Name, Base_File_Name, Long (10 ** I * 1.00));
      end loop;

      for I in 1 .. Count loop
         Measure ("read", Repetitions, Benchmark_Number.Read'Access, Base_Name, Base_File_Name, Long (10 ** I * 0.25));
         Measure ("read", Repetitions, Benchmark_Number.Read'Access, Base_Name, Base_File_Name, Long (10 ** I * 0.50));
         Measure ("read", Repetitions, Benchmark_Number.Read'Access, Base_Name, Base_File_Name, Long (10 ** I * 0.75));
         Measure ("read", Repetitions, Benchmark_Number.Read'Access, Base_Name, Base_File_Name, Long (10 ** I * 1.00));
      end loop;

      Print (Base_Name);
      Results_HM.Clear;
   end Eval_Number;

   procedure Eval_Date (Count, Repetitions : Natural) is
      Base_Name : constant String := "date";
      Base_File_Name : constant String := "tmp/benchmark-" & Base_Name;
   begin
      for I in 1 .. Count loop
         Measure ("create", Repetitions, Benchmark_Date.Create'Access, Base_Name, Base_File_Name, Long (10 ** I * 0.25));
         Measure ("write",  Repetitions, Benchmark_Date.Write'Access,  Base_Name, Base_File_Name, Long (10 ** I * 0.25));
         Measure ("create", Repetitions, Benchmark_Date.Create'Access, Base_Name, Base_File_Name, Long (10 ** I * 0.50));
         Measure ("write",  Repetitions, Benchmark_Date.Write'Access,  Base_Name, Base_File_Name, Long (10 ** I * 0.50));
         Measure ("create", Repetitions, Benchmark_Date.Create'Access, Base_Name, Base_File_Name, Long (10 ** I * 0.75));
         Measure ("write",  Repetitions, Benchmark_Date.Write'Access,  Base_Name, Base_File_Name, Long (10 ** I * 0.75));
         Measure ("create", Repetitions, Benchmark_Date.Create'Access, Base_Name, Base_File_Name, Long (10 ** I * 1.00));
         Measure ("write",  Repetitions, Benchmark_Date.Write'Access,  Base_Name, Base_File_Name, Long (10 ** I * 1.00));
      end loop;

      for I in 1 .. Count loop
         Measure ("read", Repetitions, Benchmark_Date.Read'Access, Base_Name, Base_File_Name, Long (10 ** I * 0.25));
         Measure ("read", Repetitions, Benchmark_Date.Read'Access, Base_Name, Base_File_Name, Long (10 ** I * 0.50));
         Measure ("read", Repetitions, Benchmark_Date.Read'Access, Base_Name, Base_File_Name, Long (10 ** I * 0.75));
         Measure ("read", Repetitions, Benchmark_Date.Read'Access, Base_Name, Base_File_Name, Long (10 ** I * 1.00));
      end loop;

      Print (Base_Name);
      Results_HM.Clear;
   end Eval_Date;

   procedure Eval_Graph_1 (Count, Repetitions : Natural) is
      Base_Name : constant String := "graph-1";
      Base_File_Name : constant String := "tmp/benchmark-" & Base_Name;
   begin
      for I in 1 .. Count loop
         Measure ("create", Repetitions, Benchmark_Graph_1.Create'Access, Base_Name, Base_File_Name, Long (10 ** I * 0.25));
         Measure ("write",  Repetitions, Benchmark_Graph_1.Write'Access,  Base_Name, Base_File_Name, Long (10 ** I * 0.25));
         Measure ("read",        Repetitions, Benchmark_Graph_1.Read'Access,        Base_Name, Base_File_Name, Long (10 ** I * 0.25));
         Measure ("create-more", Repetitions, Benchmark_Graph_1.Create_More'Access, Base_Name, Base_File_Name, Long (10 ** I * 0.25));
         Measure ("append",      Repetitions, Benchmark_Graph_1.Append'Access,      Base_Name, Base_File_Name, Long (10 ** I * 0.25));

         Measure ("create", Repetitions, Benchmark_Graph_1.Create'Access, Base_Name, Base_File_Name, Long (10 ** I * 0.50));
         Measure ("write",  Repetitions, Benchmark_Graph_1.Write'Access,  Base_Name, Base_File_Name, Long (10 ** I * 0.50));
         Measure ("read",        Repetitions, Benchmark_Graph_1.Read'Access,        Base_Name, Base_File_Name, Long (10 ** I * 0.50));
         Measure ("create-more", Repetitions, Benchmark_Graph_1.Create_More'Access, Base_Name, Base_File_Name, Long (10 ** I * 0.50));
         Measure ("append",      Repetitions, Benchmark_Graph_1.Append'Access,      Base_Name, Base_File_Name, Long (10 ** I * 0.50));

         Measure ("create", Repetitions, Benchmark_Graph_1.Create'Access, Base_Name, Base_File_Name, Long (10 ** I * 0.75));
         Measure ("write",  Repetitions, Benchmark_Graph_1.Write'Access,  Base_Name, Base_File_Name, Long (10 ** I * 0.75));
         Measure ("read",        Repetitions, Benchmark_Graph_1.Read'Access,        Base_Name, Base_File_Name, Long (10 ** I * 0.75));
         Measure ("create-more", Repetitions, Benchmark_Graph_1.Create_More'Access, Base_Name, Base_File_Name, Long (10 ** I * 0.75));
         Measure ("append",      Repetitions, Benchmark_Graph_1.Append'Access,      Base_Name, Base_File_Name, Long (10 ** I * 0.75));

         Measure ("create", Repetitions, Benchmark_Graph_1.Create'Access, Base_Name, Base_File_Name, Long (10 ** I * 1.00));
         Measure ("write",  Repetitions, Benchmark_Graph_1.Write'Access,  Base_Name, Base_File_Name, Long (10 ** I * 1.00));
         Measure ("read",        Repetitions, Benchmark_Graph_1.Read'Access,        Base_Name, Base_File_Name, Long (10 ** I * 1.00));
         Measure ("create-more", Repetitions, Benchmark_Graph_1.Create_More'Access, Base_Name, Base_File_Name, Long (10 ** I * 1.00));
         Measure ("append",      Repetitions, Benchmark_Graph_1.Append'Access,      Base_Name, Base_File_Name, Long (10 ** I * 1.00));
      end loop;

      Print (Base_Name);
      Results_HM.Clear;
   end Eval_Graph_1;

begin

   Ada.Text_IO.Put_Line (" >>> benchmark:");
   Ada.Text_IO.New_Line;

   --  Eval_Containers (Count => 8, Repetitions => 0);
   Eval_Graph_1 (Count => 5, Repetitions => 0);

end Benchmark;

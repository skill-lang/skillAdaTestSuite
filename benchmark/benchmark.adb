with Ada.Calendar;
with Ada.Containers.Indefinite_Hashed_Maps;
with Ada.Containers.Indefinite_Vectors;
with Ada.Containers.Ordered_Sets;
with Ada.Directories;
with Ada.Strings.Fixed;
with Ada.Strings.Hash;
with Ada.Text_IO;

--with Benchmark_I64;
--with Benchmark_V64;
--with Benchmark_Containers;

procedure Benchmark is

   Path : constant String := "tmp/benchmark-";

   subtype Long is Long_Integer;
   type Print_Type is (Print_SIZE, Print_TIME, Print_THROUGHPUT);

   use Ada.Calendar;
   use Ada.Directories;
   use Ada.Strings.Fixed;

   package Total_Size_Hashed_Map is new Ada.Containers.Indefinite_Hashed_Maps (String, Long, Ada.Strings.Hash, "=");
   package Total_Time_Hashed_Map is new Ada.Containers.Indefinite_Hashed_Maps (String, Duration, Ada.Strings.Hash, "=");
   type Total_Size_Hashed_Map_Access is access Total_Size_Hashed_Map.Map;
   type Total_Time_Hashed_Map_Access is access Total_Time_Hashed_Map.Map;

   Total_Size_HM : Total_Size_Hashed_Map_Access := new Total_Size_Hashed_Map.Map;
   Total_Time_HM : Total_Time_Hashed_Map_Access := new Total_Time_Hashed_Map.Map;

   package N_Ordered_Set is new Ada.Containers.Ordered_Sets (Integer, "<", "=");
   type N_Ordered_Set_Access is access N_Ordered_Set.Set;
   N_OS : N_Ordered_Set_Access := new N_Ordered_Set.Set;

   procedure Measure (Base_Name : String; N : Integer; J : Natural; Function_Name : String; Test : access procedure (N : Integer; File_Name : String)) is
      function Calculate (Start : Ada.Calendar.Time) return Duration is
         (Clock - Start);
      pragma Inline (Calculate);

      File_Name : constant String := Path & Base_Name & "-N" & Trim (N'Img, Ada.Strings.Left) & ".sf";
      Name : constant String := Base_Name & "-" & Trim (N'Img, Ada.Strings.Left) & "-" & Function_Name;
   begin
      Ada.Text_IO.Put_Line ("--> " & Base_Name & " " & Function_Name & " ;; N: " & Trim (N'Img, Ada.Strings.Left) & "::" & Trim (J'Img, Ada.Strings.Left));

      N_OS.Include (N);

      if not Total_Size_HM.Contains (Name) then
         Total_Size_HM.Insert (Name, 0);
      end if;

      if not Total_Time_HM.Contains (Name) then
         Total_Time_HM.Insert (Name, 0.0);
      end if;

      declare
         Start : Time := Clock;
      begin
         Test (N, File_Name);

         declare
            Measured : Duration := Calculate (Start);

            Total_Size : Long := 0;
            Total_Time : Duration := Total_Time_HM.Element (Name) + Measured;
         begin
            if "write" = Function_Name or else "read" = Function_Name or else "append" = Function_Name then
               Total_Size := Total_Size_HM.Element (Name) + Long (Size (File_Name));
            end if;

            Total_Size_HM.Replace (Name, Total_Size);
            Total_Time_HM.Replace (Name, Total_Time);
         end;
      end;
   end Measure;

   procedure Correct_Append_Size (Base_Name : String) is
      use N_Ordered_Set;

      procedure Iterate (Position : Cursor) is
         N : Long := Long (Element (Position));
         Name_Write : constant String := Base_Name & "-" & Trim (N'Img, Ada.Strings.Left) & "-write";
         Name_Append : constant String := Base_Name & "-" & Trim (N'Img, Ada.Strings.Left) & "-append";
         Corrected_Size : Long := Total_Size_HM.Element (Name_Append) - Total_Size_HM.Element (Name_Write);
      begin
         Total_Size_HM.Replace (Name_Append, Corrected_Size);
      end Iterate;
      pragma Inline (Iterate);
   begin
      N_OS.Iterate (Iterate'Access);
   end;

   function Get_String (N : Long; S : String) return String is
      ("(" & Trim (N'Img, Ada.Strings.Left) & ", " & S & ")");

   procedure Print (Base_Name : String; Repetitions : Natural; Function_Name : String; What : Print_Type) is
      use N_Ordered_Set;

      procedure Iterate_Size (Position : Cursor) is
         N : Long := Long (Element (Position));
         Name : constant String := Base_Name & "-" & Trim (N'Img, Ada.Strings.Left) & "-" & Function_Name;
         Size : Long := Total_Size_HM.Element (Name) / Long (1 + Repetitions);
         X : Duration := Duration (Size) / Duration (N);  --  size / instance
         S : String := Trim (X'Img, Ada.Strings.Left);
      begin
         Ada.Text_IO.Put (Get_String (N, S) & " ");
      end Iterate_Size;
      pragma Inline (Iterate_Size);

      procedure Iterate_Time (Position : Cursor) is
         N : Long := Long (Element (Position));
         Name : constant String := Base_Name & "-" & Trim (N'Img, Ada.Strings.Left) & "-" & Function_Name;
         Time : Duration := Total_Time_HM.Element (Name) / Duration (1 + Repetitions);
         S : String := Trim (Time'Img, Ada.Strings.Left);
      begin
         Ada.Text_IO.Put (Get_String (N, S) & " ");
      end Iterate_Time;
      pragma Inline (Iterate_Time);

      procedure Iterate_Throughput (Position : Cursor) is
         N : Long := Long (Element (Position));
         Name : constant String := Base_Name & "-" & Trim (N'Img, Ada.Strings.Left) & "-" & Function_Name;
         Size : Long := Total_Size_HM.Element (Name) / Long (1 + Repetitions);
         Time : Duration := Total_Time_HM.Element (Name) / Duration (1 + Repetitions);
         X : Duration := (Duration (Size) / (1024**2)) / Time;  --  size / time
         S : String := Trim (X'Img, Ada.Strings.Left);
      begin
         Ada.Text_IO.Put (Get_String (N, S) & " ");
      end Iterate_Throughput;
      pragma Inline (Iterate_Throughput);
   begin
      if Print_SIZE = What then
         N_OS.Iterate (Iterate_Size'Access);
      end if;

      if Print_TIME = What then
         N_OS.Iterate (Iterate_Time'Access);
      end if;

      if Print_THROUGHPUT = What then
         N_OS.Iterate (Iterate_Throughput'Access);
      end if;

      Ada.Text_IO.New_Line;
   end Print;

   procedure Reset is
   begin
      Total_Size_HM.Clear;
      Total_Time_HM.Clear;
      N_OS.Clear;
   end;

   procedure Eval_Number (Count, Repetitions : Natural) is separate;
   procedure Eval_Date (Count, Repetitions : Natural) is separate;
   procedure Eval_Graph_1 (Count, Repetitions : Natural) is separate;
   procedure Eval_Graph_2 (Count, Repetitions : Natural) is separate;

   procedure Eval_S_Number (Count, Repetitions : Natural) is separate;
   procedure Eval_S_Date (Count, Repetitions : Natural) is separate;
--   procedure Eval_S_Graph_1 (Count, Repetitions : Natural) is separate;
--   procedure Eval_S_Graph_2 (Count, Repetitions : Natural) is separate;

begin

   Ada.Text_IO.Put_Line (" >>> benchmark:");
   Ada.Text_IO.New_Line;

   Reset;
   Eval_Number (Count => 8, Repetitions => 10);
   Reset;
   Eval_Date (Count => 8, Repetitions => 10);
   Reset;
   Eval_Graph_1 (Count => 8, Repetitions => 10);
   Reset;
   Eval_Graph_2 (Count => 7, Repetitions => 10);
   Reset;
   --Eval_S_Number (Count => 0, Repetitions => 8);
   Reset;
   --Eval_S_Date (Count => 8, Repetitions => 10);
   Reset;

   --Eval_S_Graph_1 (Count => 1, Repetitions => 0);
   --Reset;
   --Eval_S_Graph_2 (Count => 0, Repetitions => 7);
   --Reset;

end Benchmark;

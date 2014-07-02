package body Benchmark_Containers is

   type A is abstract tagged null record;
   type B is new A with null record;
   type B_Access is access B;

   procedure Test_Indefinite (N : Long; File_Name : String) is
      package Vector is new Ada.Containers.Indefinite_Vectors (Positive, B_Access);
      C : Vector.Vector;
   begin
      for I in 1 .. N loop
         C.Append (new B);
      end loop;
   end Test_Indefinite;

   procedure Test_Non_Indefinite (N : Long; File_Name : String) is
      package Vector is new Ada.Containers.Vectors (Positive, B_Access);
      C : Vector.Vector;
   begin
      for I in 1 .. N loop
         C.Append (new B);
      end loop;
   end Test_Non_Indefinite;

end Benchmark_Containers;

with Ada.Streams.Stream_IO;
with Ada.Text_IO;
with Ada.Unchecked_Deallocation;
with Ada.Containers.Vectors;

package body Benchmark_S_Number is

   package Skill renames Number.Api;
   use Number;
   use Skill;

   type State_Type is access Skill_State;
   State : State_Type;

   procedure Create (N : Integer; File_Name : String) is
   begin
      State := new Skill_State;
      Skill.Create (State);

      for I in 1 .. i64 (N) loop
         New_Number (State, I);
      end loop;
   end Create;

   procedure Write (N : Integer; File_Name : String) is
      package ASS_IO renames Ada.Streams.Stream_IO;

      File : ASS_IO.File_Type;
      Stream : ASS_IO.Stream_Access;

      procedure Free is new Ada.Unchecked_Deallocation (Number_Type_Array, Number_Type_Accesses);
      Objects : Number_Type_Accesses := Skill.Get_Numbers (State);
   begin
      ASS_IO.Create (File, ASS_IO.Out_File, File_Name);
      Stream := ASS_IO.Stream (File);

      for I in Objects'Range loop
         Number_Type'Write (Stream, Objects (I).all);
      end loop;

      ASS_IO.Close (File);
      Free (Objects);
   end Write;

   procedure Read (N : Integer; File_Name : String) is
      package ASS_IO renames Ada.Streams.Stream_IO;

      File : ASS_IO.File_Type;
      Stream : ASS_IO.Stream_Access;

      package Vector is new Ada.Containers.Vectors (Positive, Number_Type);
      Storage_Pool : Vector.Vector;
   begin
      ASS_IO.Open (File, ASS_IO.In_File, File_Name);
      Stream := ASS_IO.Stream (File);

      while not ASS_IO.End_Of_File (File) loop
         declare
            X : Number_Type;
         begin
            Number_Type'Read (Stream, X);
            Storage_Pool.Append (X);
         end;
      end loop;

      ASS_IO.Close (File);
   end Read;

   procedure Reset (N : Integer; File_Name : String) is
      procedure Free is new Ada.Unchecked_Deallocation (Skill_State, State_Type);
   begin
      Skill.Close (State);
      Free (State);
   end Reset;

end Benchmark_S_Number;

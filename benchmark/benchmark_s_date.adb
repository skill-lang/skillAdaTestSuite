with Ada.Streams.Stream_IO;
with Ada.Text_IO;
with Ada.Unchecked_Deallocation;
with Ada.Containers.Vectors;

package body Benchmark_S_Date is

   package Skill renames Date.Api;
   use Date;
   use Skill;

   type State_Type is access Skill_State;
   State : State_Type;

   procedure Create (N : Integer; File_Name : String) is
   begin
      State := new Skill_State;
      Skill.Create (State);

      for I in 1 .. i64 (N) loop
         New_Date (State, I);
      end loop;
   end Create;

   procedure Write (N : Integer; File_Name : String) is
      package ASS_IO renames Ada.Streams.Stream_IO;

      File : ASS_IO.File_Type;
      Stream : ASS_IO.Stream_Access;

      procedure Free is new Ada.Unchecked_Deallocation (Date_Type_Array, Date_Type_Accesses);
      Objects : Date_Type_Accesses := Skill.Get_Dates (State);
   begin
      ASS_IO.Create (File, ASS_IO.Out_File, File_Name);
      Stream := ASS_IO.Stream (File);

      for I in Objects'Range loop
         Date_Type'Write (Stream, Objects (I).all);
      end loop;

      ASS_IO.Close (File);
      Free (Objects);
   end Write;

   procedure Read (N : Integer; File_Name : String) is
      package ASS_IO renames Ada.Streams.Stream_IO;

      File : ASS_IO.File_Type;
      Stream : ASS_IO.Stream_Access;

      package Vector is new Ada.Containers.Vectors (Positive, Date_Type);
      Storage_Pool : Vector.Vector;
   begin
      ASS_IO.Open (File, ASS_IO.In_File, File_Name);
      Stream := ASS_IO.Stream (File);

      while not ASS_IO.End_Of_File (File) loop
         declare
            X : Date_Type;
         begin
            Date_Type'Read (Stream, X);
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

end Benchmark_S_Date;

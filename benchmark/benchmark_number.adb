with Ada.Unchecked_Deallocation;

with Number.Api;

package body Benchmark_Number is

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
   begin
      Skill.Write (State, File_Name);
   end Write;

   procedure Read (N : Integer; File_Name : String) is
   begin
      State := new Skill_State;
      Skill.Read (State, File_Name);
   end Read;

   procedure Create_More (N : Integer; File_Name : String) is
   begin
      for I in 1 .. i64 (N) loop
         New_Number (State, I);
      end loop;
   end Create_More;

   procedure Append (N : Integer; File_Name : String) is
   begin
      Skill.Append (State);
   end Append;

   procedure Reset (N : Integer; File_Name : String) is
      procedure Free is new Ada.Unchecked_Deallocation (Skill_State, State_Type);
   begin
      Skill.Close (State);
      Free (State);
   end Reset;

end Benchmark_Number;

with Number;
with Number.Api;

package body Benchmark_Number is

   package Skill renames Number.Api;
   use Number;
   use Skill;

   State : access Skill_State;

   procedure Create (N : Long; File_Name : String) is
   begin
      State := new Skill_State;
      Skill.Create (State);

      for I in 1 .. i64 (N) loop
         New_Number (State, I);
      end loop;
   end Create;

   procedure Write (N : Long; File_Name : String) is
   begin
      Skill.Write (State, File_Name);
   end Write;

   procedure Read (N : Long; File_Name : String) is
      State : access Skill_State := new Skill_State;
   begin
      Skill.Read (State, File_Name);
   end Read;

end Benchmark_Number;
with Ada.Unchecked_Deallocation;
with Date.Api;

package body Benchmark_Date is

   package Skill renames Date.Api;
   use Date;
   use Skill;

   type State_Type is access Skill_State;
   State : State_Type;

   procedure Create (N : Long; File_Name : String) is
   begin
      State := new Skill_State;
      Skill.Create (State);

      for I in 1 .. i64 (N) loop
         New_Date (State, I);
      end loop;
   end Create;

   procedure Write (N : Long; File_Name : String) is
   begin
      Skill.Write (State, File_Name);
   end Write;

   procedure Read (N : Long; File_Name : String) is
   begin
      State := new Skill_State;
      Skill.Read (State, File_Name);
   end Read;

   procedure Create_More (N : Long; File_Name : String) is
   begin
      for I in 1 .. i64 (N) loop
         New_Date (State, I);
      end loop;
   end Create_More;

   procedure Append (N : Long; File_Name : String) is
   begin
      Skill.Append (State);
   end Append;

   procedure Reset (N : Long; File_Name : String) is
      procedure Free_Date is new Ada.Unchecked_Deallocation (Date_Type, Date_Type_Access);
      procedure Free_State is new Ada.Unchecked_Deallocation (Skill_State, State_Type);
   begin
      declare
         X : Date_Type_Accesses := Get_Dates (State);
      begin
         for I in X'Range loop
            Free_Date (X (I));
         end loop;
      end;
      Free_State (State);
   end Reset;

end Benchmark_Date;
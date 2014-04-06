with Ada.Numerics.Discrete_Random;
with Ada.Text_IO;
with Ada.Unchecked_Deallocation;

package body Benchmark_Graph_1 is

   package Skill renames Graph_1.Api;
   use Graph_1;
   use Skill;

   type State_Type is access Skill_State;
   State : State_Type;

   function Random (N : Long; J : i64) return i64 is
      subtype Rand_Range is i64 range 1 .. i64 (N);
      package Rand_Int is new Ada.Numerics.Discrete_Random (Rand_Range);
      Generator : Rand_Int.Generator;
   begin
      Rand_Int.Reset (Generator, 13373 * Integer (N) * Integer (J));
      return Rand_Int.Random (Generator);
   end Random;
   pragma Inline (Random);

   procedure Create (N : Long; File_Name : String) is
      type Objects_Type is array (1 .. i64 (N)) of Node_Type_Access;
      type Objects_Type_Access is access Objects_Type;
      Objects : Objects_Type_Access := new Objects_Type;
   begin
      State := new Skill_State;
      Skill.Create (State);

      for I in 1 .. i64 (N) loop
         Objects (I) := New_Node (State, null, null, null, null);
      end loop;

      for I in 1 .. i64 (N) loop
         declare
            X : Node_Type_Access := Objects (I);
         begin
            X.Set_North (Objects (Random (N, I + 1)));
            X.Set_East (Objects (Random (N, I + 2)));
            X.Set_South (Objects (Random (N, I + 3)));
            X.Set_West (Objects (Random (N, I + 4)));
         end;
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
      type Objects_Type is array (1 .. i64 (N)) of Node_Type_Access;
      type Objects_Type_Access is access Objects_Type;
      Objects : Objects_Type_Access := new Objects_Type;
   begin
      for I in 1 .. i64 (N) loop
         Objects (I) := New_Node (State, null, null, null, null);
      end loop;

      for I in 1 .. i64 (N) loop
         declare
            X : Node_Type_Access := Objects (I);
         begin
            X.Set_North (Objects (Random (N, I + 1)));
            X.Set_East (Objects (Random (N, I + 2)));
            X.Set_South (Objects (Random (N, I + 3)));
            X.Set_West (Objects (Random (N, I + 4)));
         end;
      end loop;
   end Create_More;

   procedure Append (N : Long; File_Name : String) is
   begin
      Skill.Append (State);
   end Append;

   procedure Reset (N : Long; File_Name : String) is
      procedure Free_Node is new Ada.Unchecked_Deallocation (Node_Type, Node_Type_Access);
      procedure Free_State is new Ada.Unchecked_Deallocation (Skill_State, State_Type);
   begin
      declare
         X : Node_Type_Accesses := Get_Nodes (State);
      begin
         for I in X'Range loop
            Free_Node (X (I));
         end loop;
      end;
      Free_State (State);
   end Reset;

end Benchmark_Graph_1;

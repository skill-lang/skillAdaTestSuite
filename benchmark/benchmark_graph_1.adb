with Ada.Numerics.Discrete_Random;
with Ada.Text_IO;
with Ada.Unchecked_Deallocation;
with Hashing;

with Graph_1.Api;

package body Benchmark_Graph_1 is

   package Skill renames Graph_1.Api;
   use Graph_1;
   use Skill;

   type State_Type is access Skill_State;
   State : State_Type;

   procedure Create (N : Integer; File_Name : String) is
      function Hash is new Hashing.Discrete_Hash (Integer);

      type Objects_Type is array (0 .. N-1) of Node_Type_Access;
      type Objects_Type_Access is access Objects_Type;
      Objects : Objects_Type_Access := new Objects_Type;
      procedure Free is new Ada.Unchecked_Deallocation (Objects_Type, Objects_Type_Access);
   begin
      State := new Skill_State;
      Skill.Create (State);

      for I in 0 .. N-1 loop
         Objects (I) := New_Node (State, null, null, null, null);
      end loop;

      for I in 0 .. N-1 loop
         declare
            X : Node_Type_Access := Objects (I);

            A : Integer := Integer (Hash (N + I, 13371)) mod N;
            B : Integer := Integer (Hash (N + I, 13372)) mod N;
            C : Integer := Integer (Hash (N + I, 13373)) mod N;
            D : Integer := Integer (Hash (N + I, 13374)) mod N;
         begin
            --  Ada.Text_IO.Put_Line (A'Img & B'Img & C'Img & D'Img);

            X.Set_North (Objects (A));
            X.Set_East (Objects (B));
            X.Set_South (Objects (C));
            X.Set_West (Objects (D));
         end;
      end loop;

      Free (Objects);
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
      function Hash is new Hashing.Discrete_Hash (Integer);

      type Objects_Type is array (0 .. N-1) of Node_Type_Access;
      type Objects_Type_Access is access Objects_Type;
      Objects : Objects_Type_Access := new Objects_Type;
      procedure Free is new Ada.Unchecked_Deallocation (Objects_Type, Objects_Type_Access);
   begin
      for I in 0 .. N-1 loop
         Objects (I) := New_Node (State, null, null, null, null);
      end loop;

      for I in 0 .. N-1 loop
         declare
            X : Node_Type_Access := Objects (I);

            A : Integer := Integer (Hash (N + I, 13375)) mod N;
            B : Integer := Integer (Hash (N + I, 13376)) mod N;
            C : Integer := Integer (Hash (N + I, 13377)) mod N;
            D : Integer := Integer (Hash (N + I, 13378)) mod N;
         begin
            --  Ada.Text_IO.Put_Line (A'Img & B'Img & C'Img & D'Img);

            X.Set_North (Objects (A));
            X.Set_East (Objects (B));
            X.Set_South (Objects (C));
            X.Set_West (Objects (D));
         end;
      end loop;

      Free (Objects);
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

end Benchmark_Graph_1;

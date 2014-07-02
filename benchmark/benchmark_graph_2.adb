with Ada.Numerics.Discrete_Random;
with Ada.Text_IO;
with Ada.Unchecked_Deallocation;
with Hashing;

with Graph_2.Api;

package body Benchmark_Graph_2 is

   package Skill renames Graph_2.Api;
   use Graph_2;
   use Skill;

   type State_Type is access Skill_State;
   State : State_Type;

   String_Black : String_Access;
   String_Red : String_Access;

   procedure Create (N : Integer; File_Name : String) is
      function Hash is new Hashing.Discrete_Hash (Integer);

      type Objects_Type is array (0 .. N-1) of Node_Type_Access;
      type Objects_Type_Access is access Objects_Type;
      Objects : Objects_Type_Access := new Objects_Type;
      procedure Free is new Ada.Unchecked_Deallocation (Objects_Type, Objects_Type_Access);
   begin
      String_Black := new String'("black");
      String_Red := new String'("red");

      State := new Skill_State;
      Skill.Create (State);

      for I in 0 .. N-1 loop
         declare
            Name : String_Access := String_Black;
            Edges : Node_Edges_Set.Set;
         begin
            if 0 = I mod 2 then
               Name := String_Red;
            end if;
            Objects (I) := New_Node (State, Name, Edges);
         end;
      end loop;

      for I in 0 .. N-1 loop
         declare
            X : Node_Type_Access := Objects (I);
            Edges : Node_Edges_Set.Set := X.Get_Edges;
            J : Integer := 0;
         begin
            while (50 >= N and then N > Integer (Edges.Length)) or else (50 < N and then 50 > Integer (Edges.Length)) loop
               J := J + 1;
               declare
                  A : Integer := Integer (Hash (N + I + J, 13371)) mod N;
               begin
                  --  Ada.Text_IO.Put_Line (A'Img);
                  --  Ada.Text_IO.Put_Line (Node_Edges_Set.Has_Element (Edges.Find (Objects (A)))'Img);
                  --Edges.Insert (Objects (A));
                  if not Edges.Contains (Objects (A)) then
                     Edges.Insert (Objects (A));
                     --  Ada.Text_IO.Put_Line (A'Img);
                  end if;
               end;
            end loop;
            --  Ada.Text_IO.Put_Line ("l: " & Edges.Length'Img);
            X.Set_Edges (Edges);
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
      String_Black := new String'("black");
      String_Red := new String'("red");

      for I in 0 .. N-1 loop
         declare
            Name : String_Access := String_Black;
            Edges : Node_Edges_Set.Set;
         begin
            if 0 = I mod 2 then
               Name := String_Red;
            end if;
            Objects (I) := New_Node (State, Name, Edges);
         end;
      end loop;

      for I in 0 .. N-1 loop
         declare
            X : Node_Type_Access := Objects (I);
            Edges : Node_Edges_Set.Set := X.Get_Edges;
            J : Integer := 0;
         begin
            while (50 >= N and then N > Integer (Edges.Length)) or else (50 < N and then 50 > Integer (Edges.Length)) loop
               J := J + 1;
               declare
                  A : Integer := Integer (Hash (N + I + J, 13372)) mod N;
               begin
                  --  Ada.Text_IO.Put_Line (A'Img);
                  if not Edges.Contains (Objects (A)) then
                     Edges.Insert (Objects (A));
                  end if;
               end;
            end loop;
            X.Set_Edges (Edges);
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
      procedure Free is new Ada.Unchecked_Deallocation (String, String_Access);
   begin
      Skill.Close (State);
      Free (String_Black);
      Free (String_Red);
      Free (State);
   end Reset;

end Benchmark_Graph_2;

with Ada.Numerics.Discrete_Random;
with Ada.Streams.Stream_IO;
with Ada.Text_IO;
with Ada.Unchecked_Deallocation;
with Hashing;
with Ada.Containers.Vectors;

package body Benchmark_S_Graph_2 is

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
      package ASS_IO renames Ada.Streams.Stream_IO;

      File : ASS_IO.File_Type;
      Stream : ASS_IO.Stream_Access;

      procedure Free is new Ada.Unchecked_Deallocation (Node_Type_Array, Node_Type_Accesses);
      Objects : Node_Type_Accesses := Skill.Get_Nodes (State);
   begin
      ASS_IO.Create (File, ASS_IO.Out_File, File_Name);
      Stream := ASS_IO.Stream (File);

      for I in Objects'Range loop
         Node_Type'Output (Stream, Objects (I).all);
      end loop;

      ASS_IO.Close (File);
      Free (Objects);
   end Write;

   procedure Read (N : Integer; File_Name : String) is
      package ASS_IO renames Ada.Streams.Stream_IO;

      File : ASS_IO.File_Type;
      Stream : ASS_IO.Stream_Access;

      package Vector is new Ada.Containers.Vectors (Positive, Node_Type);
      Storage_Pool : Vector.Vector;
   begin
      ASS_IO.Open (File, ASS_IO.In_File, File_Name);
      Stream := ASS_IO.Stream (File);

      while not ASS_IO.End_Of_File (File) loop
         declare
            X : Node_Type := Node_Type'Input (Stream);
         begin
            Storage_Pool.Append (X);

            declare
               use Node_Edges_Set;

               procedure Iterate (Position : Cursor) is
                  X : Node_Type_Access := Element (Position);
               begin
                  Ada.Text_IO.Put_Line (X.Get_Color.all);
               end Iterate;
            begin
               X.Get_Edges.Iterate (Iterate'Access);
            end;
         end;
      end loop;

      ASS_IO.Close (File);
   end Read;

   procedure Reset (N : Integer; File_Name : String) is
      procedure Free is new Ada.Unchecked_Deallocation (Skill_State, State_Type);
      procedure Free is new Ada.Unchecked_Deallocation (String, String_Access);
   begin
      Skill.Close (State);
      --Free (String_Black);
      --Free (String_Red);
      Free (State);
   end Reset;

end Benchmark_S_Graph_2;

with Ada.Numerics.Discrete_Random;
with Ada.Streams.Stream_IO;
with Ada.Text_IO;
with Ada.Unchecked_Deallocation;
with Hashing;
with Ada.Containers.Vectors;

package body Benchmark_S_Graph_1 is

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
      package ASS_IO renames Ada.Streams.Stream_IO;

      File : ASS_IO.File_Type;
      Stream : ASS_IO.Stream_Access;

      procedure Free is new Ada.Unchecked_Deallocation (Node_Type_Array, Node_Type_Accesses);
      Objects : Node_Type_Accesses := Skill.Get_Nodes (State);
   begin
      ASS_IO.Create (File, ASS_IO.Out_File, File_Name);
      Stream := ASS_IO.Stream (File);

      for I in Objects'Range loop
         Node_Type'Write (Stream, Objects (I).all);
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
            X : Node_Type;
         begin
            Node_Type'Read (Stream, X);
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

end Benchmark_S_Graph_1;

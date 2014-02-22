package body Node.Internal.File_Parser is

   package Byte_Reader renames Node.Internal.Byte_Reader;

   State : access Skill_State;

   procedure Read (pState : access Skill_State; File_Name : String) is
      Input_File : ASS_IO.File_Type;
   begin
      State := pState;

      ASS_IO.Open (Input_File, ASS_IO.In_File, File_Name);
      Byte_Reader.Initialize (ASS_IO.Stream (Input_File));

      Ada.Text_IO.Put_Line (File_Name);

      while (not ASS_IO.End_Of_File (Input_File)) loop
         Read_String_Block;
         Read_Type_Block;
      end loop;

      ASS_IO.Close (Input_File);
   end Read;

   procedure Read_String_Block is
      Count : Long := Byte_Reader.Read_v64;
      String_Lengths : array (1 .. Count) of Integer;
      Last_End : Integer := 0;
   begin
      --  read ends and calculate lengths
      for I in String_Lengths'Range loop
         declare
            String_End : Integer := Byte_Reader.Read_i32;
            String_Length : Integer := String_End - Last_End;
         begin
            String_Lengths (I) := String_End - Last_End;
            Last_End := String_End;
         end;
      end loop;

      --  read strings
      for I in String_Lengths'Range loop
         declare
            String_Length : Integer := String_Lengths (I);
            Next_String : String := Byte_Reader.Read_String (String_Length);
         begin
            State.Put_String (Next_String);
         end;
      end loop;
   end Read_String_Block;

   procedure Read_Type_Block is
      Count : Long := Byte_Reader.Read_v64;
   begin
      for I in 1 .. Count loop
         Read_Type_Declaration;
      end loop;

      Read_Field_Data;
   end Read_Type_Block;

   procedure Read_Type_Declaration is
      Type_Name : String := State.Get_String (Byte_Reader.Read_v64);
      Instances_Count : Long;

      Skill_Unsupported_File_Format : exception;
   begin
      if (not State.Has_Type (Type_Name)) then
         declare
            Type_Super : Long := Byte_Reader.Read_v64;

            New_Type_Fields : Fields_Vector.Vector;
            New_Type_Storage_Pool : Storage_Pool_Vector.Vector;
            New_Type : Type_Information := new Type_Declaration'
               (Type_Name'Length, Type_Name, Type_Super, New_Type_Fields, New_Type_Storage_Pool);
         begin
            State.Put_Type (New_Type);
         end;

         Instances_Count := Byte_Reader.Read_v64;
         Skip_Restrictions;
      else
         Instances_Count := Byte_Reader.Read_v64;
      end if;

      if 0 = Instances_Count then
         raise Skill_Unsupported_File_Format;
      else
         declare
            Field_Count : Long := Byte_Reader.Read_v64;
            Known_Fields : Long := State.Known_Fields (Type_Name);
            Last_Offset : Long := 0;
         begin
            for I in 1 .. Field_Count loop
               if Field_Count > Known_Fields then
                  Read_Field_Declaration (Type_Name);
               end if;

               declare
                  Offset : Long := Byte_Reader.Read_v64;
                  Data_Length : Long := Offset - Last_Offset;
                  Field : Field_Information := State.Get_Field (Type_Name, I);
                  Chunk : Data_Chunk (Type_Name'Length) := (Type_Name'Length, Type_Name, Instances_Count, Data_Length, 1);
               begin
                  Last_Offset := Offset;
                  Data_Chunks.Append (Chunk);
               end;
            end loop;
         end;
      end if;
   end Read_Type_Declaration;

   procedure Read_Field_Declaration (Type_Name : String) is
   begin
      Skip_Restrictions;

      declare
         Field_Type : Short_Short_Integer := Byte_Reader.Read_i8;
         Field_Name : String := State.Get_String (Byte_Reader.Read_v64);

         New_Field : Field_Information := new Field_Declaration'(Field_Name'Length, Field_Name, Field_Type);
      begin
         State.Put_Field (Type_Name, New_Field);
      end;
   end Read_Field_Declaration;

   procedure Read_Field_Data is
   begin
      Data_Chunks.Iterate (Data_Chunk_Vector_Iterator'Access);
      Data_Chunks.Clear;
   end Read_Field_Data;

   procedure Data_Chunk_Vector_Iterator (Iterator : Data_Chunk_Vector.Cursor) is
      type Type_Names is (node);
      function Convert (X : String) return Type_Names is
         Skill_Unexpected_Type_Name : exception;
      begin
         if "node" = X then
            return node;
         end if;

         raise Skill_Unexpected_Type_Name;
      end Convert;

      type Field_Names is (id);
      function Convert (X : String) return Field_Names is
         Skill_Unexpected_Field_Name : exception;
      begin
         if "id" = X then
            return id;
         end if;

         raise Skill_Unexpected_Field_Name;
      end Convert;

      Chunk : Data_Chunk := Data_Chunk_Vector.Element (Iterator);
      A_Type : Type_Information := State.Get_Type (Chunk.Type_Name);
      Type_Name : Type_Names := Convert (Chunk.Type_Name);

      type id_Type is array (1 .. Chunk.Instances_Count) of i8;
      ids : id_Type;
   begin
      Exit_Loop:
      for I in 1 .. Chunk.Instances_Count loop
         for J in 1 .. State.Known_Fields (Chunk.Type_Name) loop
            declare
               Field_Name : Field_Names := Convert (State.Get_Field (Chunk.Type_Name, J).Name);
            begin
               case Type_Name is
                  when node =>
                     case Field_Name is
                        when id => ids (I) := Byte_Reader.Read_i8;
                        when others => null;
                     end case;
                  when others => Byte_Reader.Skip_Bytes (Chunk.Data_Length); exit Exit_Loop;
               end case;
            end;
         end loop;

         declare
            New_Node : Node_Object := (id => ids (I));
         begin
            State.Put (Chunk.Type_Name, New_Node);
         end;
      end loop Exit_Loop;
   end Data_Chunk_Vector_Iterator;

   procedure Skip_Restrictions is
      X : Long := Byte_Reader.Read_v64;
   begin
      null;
   end Skip_Restrictions;

end Node.Internal.File_Parser;

--  ___ _  ___ _ _                                                            --
-- / __| |/ (_) | |       Your SKilL Ada Binding                              --
-- \__ \ ' <| | | |__     <<debug>>                                           --
-- |___/_|\_\_|_|____|    by: <<some developer>>                              --
--                                                                            --

package body Date.Internal.File_Reader is

   State : access Skill_State;

   procedure Read (pState : access Skill_State; File_Name : String) is
      Input_File : ASS_IO.File_Type;
   begin
      State := pState;

      ASS_IO.Open (Input_File, ASS_IO.In_File, File_Name);
      Byte_Reader.Initialize (ASS_IO.Stream (Input_File));

      while (not ASS_IO.End_Of_File (Input_File)) loop
         Read_String_Block;
         Read_Type_Block;
         Update_Base_Pool_Start_Index;
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
      Last_End : Long := 0;
   begin
      for I in 1 .. Count loop
         Read_Type_Declaration (Last_End);
      end loop;

      Read_Field_Data;
   end Read_Type_Block;

   procedure Read_Type_Declaration (Last_End : in out Long) is
      Type_Name : String := State.Get_String (Byte_Reader.Read_v64);
      Instance_Count : Natural;
      Field_Count : Long;

      Skill_Unsupported_File_Format : exception;
   begin
      if not State.Has_Type (Type_Name) then
         declare
            Super_Name : Long := Byte_Reader.Read_v64;

            New_Type_Fields : Fields_Vector.Vector;
            New_Type_Storage_Pool : Storage_Pool_Vector.Vector;
            New_Type : Type_Information := new Type_Declaration'
              (Size => Type_Name'Length,
               Name => Type_Name,
               Super_Name => Super_Name,
               bpsi => 1,
               lbpsi => 1,
               Fields => New_Type_Fields,
               Storage_Pool => New_Type_Storage_Pool);
         begin
            State.Put_Type (New_Type);
         end;

         if 0 /= State.Get_Type (Type_Name).Super_Name then
            State.Get_Type (Type_Name).lbpsi := Positive (Byte_Reader.Read_v64);
         end if;

         Instance_Count := Natural (Byte_Reader.Read_v64);
         Skip_Restrictions;
      else
         if 0 /= State.Get_Type (Type_Name).Super_Name then
            State.Get_Type (Type_Name).lbpsi := Positive (Byte_Reader.Read_v64);
         end if;

         Instance_Count := Natural (Byte_Reader.Read_v64);
      end if;

      Field_Count := Byte_Reader.Read_v64;

      if 0 = Instance_Count then
         raise Skill_Unsupported_File_Format;
      else
         declare
            Known_Fields : Long := State.Known_Fields (Type_Name);
            Start_Index : Natural := State.Storage_Pool_Size (Type_Name) + 1;
            End_Index : Natural := Start_Index + Instance_Count - 1;
         begin
            Create_Objects (Type_Name, Instance_Count);

            for I in 1 .. Field_Count loop
               if Field_Count > Known_Fields then
                  Read_Field_Declaration (Type_Name);
               end if;

               declare
                  Field_End : Long := Byte_Reader.Read_v64;
                  Data_Length : Long := Field_End - Last_End;
                  Field : Field_Information := State.Get_Field (Type_Name, I);
                  Chunk : Data_Chunk (Type_Name'Length, Field.Name'Length) :=
                    (Type_Size => Type_Name'Length,
                     Field_Size => Field.Name'Length,
                     Type_Name => Type_Name,
                     Field_Name => Field.Name,
                     Start_Index => Start_Index,
                     End_Index => End_Index,
                     Data_Length => Data_Length);
               begin
                  Last_End := Field_End;
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
      begin
         case Field_Type is
            --  unused
            when Short_Short_Integer'First .. -1 | 16 | 21 .. 31 =>
               null;

            --  constants i8, i16, i32, i64, v64
            when 0 .. 4 =>
               null;

            --  annotation, bool, i8, i16, i32, i64, v64, f32, f64, string
            when 5 .. 14 =>
               null;

            --  array T[i]
            when 15 =>
               declare
                  X : Long := Byte_Reader.Read_v64;
                  Y : Short_Short_Integer := Byte_Reader.Read_i8;
               begin
                  null;
               end;

            --  array T[], list, set
            when 17 .. 19 =>
               declare
                  X : Short_Short_Integer := Byte_Reader.Read_i8;
               begin
                  null;
               end;

            --  map
            when 20 =>
               declare
                  X : Long := Byte_Reader.Read_v64;
               begin
                  for I in 1 .. X loop
                     declare
                        Y : Short_Short_Integer := Byte_Reader.Read_i8;
                     begin
                        null;
                     end;
                  end loop;
               end;

            --  user type
            when 32 .. Short_Short_Integer'Last =>
               null;

            when others => null;
         end case;

         declare
            Field_Name : String := State.Get_String (Byte_Reader.Read_v64);

            New_Field : Field_Information := new Field_Declaration'
              (Size => Field_Name'Length,
               Name => Field_Name,
               F_Type => Field_Type);
         begin
            State.Put_Field (Type_Name, New_Field);
         end;
      end;
   end Read_Field_Declaration;

   procedure Read_Field_Data is
   begin
      Data_Chunks.Iterate (Data_Chunk_Vector_Iterator'Access);
      Data_Chunks.Clear;
   end Read_Field_Data;

   procedure Update_Base_Pool_Start_Index is
   begin
      if State.Has_Type ("date") then
         State.Get_Type ("date").bpsi := State.Storage_Pool_Size ("date") + 1;
      end if;
   end Update_Base_Pool_Start_Index;

   procedure Create_Objects (Type_Name : String; Instance_Count : Natural) is
   begin
      if "date" = Type_Name then
         for I in 1 .. Instance_Count loop
            declare
               Object : Skill_Type_Access := new Date_Type'
                 (date => 0);
            begin
               State.Put_Object (Type_Name, Object);
            end;
         end loop;
      end if;
   end Create_Objects;

   procedure Data_Chunk_Vector_Iterator (Iterator : Data_Chunk_Vector.Cursor) is
      Chunk : Data_Chunk := Data_Chunk_Vector.Element (Iterator);
      Skip_Bytes : Boolean := True;

      Skill_Parse_Error : exception;
   begin
      if "date" = Chunk.Type_Name and then "date" = Chunk.Field_Name then
         for I in Chunk.Start_Index .. Chunk.End_Index loop
            declare
            Object : Date_Type_Access := Date_Type_Access (State.Get_Object (Chunk.Type_Name, I));
            begin
               Object.date := Byte_Reader.Read_v64;
            end;
         end loop;
         Skip_Bytes := False;
      end if;

      if True = Skip_Bytes then
         Byte_Reader.Skip_Bytes (Chunk.Data_Length);
      end if;
   end Data_Chunk_Vector_Iterator;

   procedure Skip_Restrictions is
      Zero : Long := Byte_Reader.Read_v64;
   begin
      null;
   end Skip_Restrictions;

end Date.Internal.File_Reader;

package body Date.Internal.File_Parser is

   package Byte_Reader renames Date.Internal.Byte_Reader;
   package String_Pool renames Date.Internal.String_Pool;

   State : Skill_State;
   Data_Queue : Data_Queue_Vector.Vector;

   procedure Read (pState : Skill_State; File_Name : String) is
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
            String_Pool.Append (State, Next_String);
         end;
      end loop;
   end Read_String_Block;

   procedure Read_Type_Block is
      count : Long := Byte_Reader.Read_v64;
   begin
      for I in 1 .. count loop
         Read_Type_Declaration;
      end loop;

      Read_Field_Data;
   end Read_Type_Block;

   procedure Read_Type_Declaration is
      tname : SU.Unbounded_String := String_Pool.Get (State, Byte_Reader.Read_v64);
      instances_count : Long;
   begin
      if (not State.Type_Declarations.Contains (tname)) then
         declare
            Type_Declaration : Type_Declaration_Access;
            tsuper : Long := Byte_Reader.Read_v64;
            tfields : Field_Declarations_Vector.Vector;
         begin
            instances_count := Byte_Reader.Read_v64;
            Type_Declaration := new Type_Declaration_Type'(tname => tname, tsuper => tsuper, tfields => tfields);
            State.Type_Declarations.Insert (tname, Type_Declaration);
         end;

         --  skip restrictions
         declare skip_restrictions : Long := Byte_Reader.Read_v64; begin null; end;
      else
         instances_count := Byte_Reader.Read_v64;
      end if;

      --  add type to data chunks
      declare
         New_Data_Queue : Data_Queue_Type := (tname, instances_count);
      begin
         Data_Queue.Append (New_Data_Queue);
      end;

      --  read field declaration
      declare
         fieldCount : Long := Byte_Reader.Read_v64;
         knownFields : Long := Long (State.Type_Declarations.Element (tname).tfields.Length);
      begin
         for I in 1 .. fieldCount loop
            if fieldCount > knownFields then
               Read_Field_Declaration (tname);
            end if;

            declare
               foffset : Long := Byte_Reader.Read_v64;
            begin
               null;
            end;
         end loop;
      end;

   end Read_Type_Declaration;

   procedure Read_Field_Declaration (tname : SU.Unbounded_String) is
   begin
      --  skip restrictions
      declare skip_restrictions : Long := Byte_Reader.Read_v64; begin null; end;

      declare
         ftype : i8 := Byte_Reader.Read_i8;
         fname : SU.Unbounded_String := String_Pool.Get (State, Byte_Reader.Read_v64);
         new_field_declaration : Field_Declaration_Access := new Field_Declaration_Type'(ftype, fname);
         Type_Declaration : Type_Declaration_Access := State.Type_Declarations.Element (tname);
         fields : Field_Declarations_Vector.Vector := Type_Declaration.tfields;
      begin
         Type_Declaration.tfields.Append (new_field_declaration);
      end;
   end Read_Field_Declaration;

   procedure Read_Field_Data is
   begin
      for I in 1 .. Natural (Data_Queue.Length) loop
         declare
            Next_Data_Queue : Data_Queue_Type := Data_Queue.Element (I);
            Type_Declaration : Type_Declaration_Access := State.Type_Declarations.Element (Next_Data_Queue.type_name);
         begin
            for J in 1 .. Natural (Type_Declaration.tfields.Length) loop
               declare
                  field_declaration : Field_Declaration_Access := Type_Declaration.tfields.Element (J);
               begin
                  for K in 1 .. Next_Data_Queue.instances_count loop
                     case field_declaration.ftype is
                        when 7 =>  --  i8
                           declare
                              new_node : Node_Type_Access := new Node_Type'(id => Byte_Reader.Read_i8);
                           begin
                              State.Node_Storage_Pool.Append (new_node);
                           end;
                        when 11 =>  --  v64
                           declare
                              new_date : Date_Type_Access := new Date_Type'(date => Byte_Reader.Read_v64);
                           begin
                              State.Date_Storage_Pool.Append (new_date);
                           end;
                        when others => null;
                     end case;
                  end loop;
               end;
            end loop;
         end;
      end loop;
      Data_Queue.Clear;
   end Read_Field_Data;

end Date.Internal.File_Parser;

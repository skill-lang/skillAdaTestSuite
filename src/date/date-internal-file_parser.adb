package body Date.Internal.File_Parser is

   package Byte_Reader renames Date.Internal.Byte_Reader;
   package String_Pool renames Date.Internal.String_Pool;

   procedure Read (State : Skill_State; File_Name : String) is
      Input_File : ASS_IO.File_Type;
   begin
      ASS_IO.Open (Input_File, ASS_IO.In_File, File_Name);
      Byte_Reader.Initialize (ASS_IO.Stream (Input_File));

      Ada.Text_IO.Put_Line (File_Name);

      while (not ASS_IO.End_Of_File (Input_File)) loop
         Read_String_Block (State);
         Read_Type_Block (State);
      end loop;

      ASS_IO.Close (Input_File);
   end Read;

   procedure Read_String_Block (State : Skill_State) is
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

   procedure Read_Type_Block (State : Skill_State) is
      count : Long := Byte_Reader.Read_v64;
   begin
      for I in 1 .. count loop
         Read_Type_Declaration (State);
      end loop;

      Read_Field_Data (State);
   end Read_Type_Block;

   procedure Read_Type_Declaration (State : Skill_State) is
      name : SU.Unbounded_String := String_Pool.Get (State, Byte_Reader.Read_v64);
   begin
      if (not State.Type_Declarations.Contains (name)) then
         declare
            super : Long := Byte_Reader.Read_v64;
         begin
            State.instancesCount := Byte_Reader.Read_v64;
         end;

         declare
            tmp : Type_Declaration_Type := (name => name);
         begin
            State.Type_Declarations.Insert (name, tmp);
         end;

         --  skip restrictions
         declare skip_restrictions : Long := Byte_Reader.Read_v64; begin null; end;
      else
         State.instancesCount := Byte_Reader.Read_v64;
      end if;

      --  read field declaration
      declare
         fieldCount : Long := Byte_Reader.Read_v64;
      begin
         for I in 1 .. fieldCount loop
            if fieldCount > State.knownFields then
               Read_Field_Declaration (State);
            end if;

            declare
               offset : Long := Byte_Reader.Read_v64;
            begin
               null;
            end;
         end loop;
      end;
   end Read_Type_Declaration;

   procedure Read_Field_Declaration (State : Skill_State) is
   begin
      --  skip restrictions
      declare skip_restrictions : Long := Byte_Reader.Read_v64; begin null; end;

      declare
         ftype : i8 := Byte_Reader.Read_i8;
         name : SU.Unbounded_String := String_Pool.Get (State, Byte_Reader.Read_v64);
      begin
         State.fieldType := ftype;
         State.knownFields := State.knownFields + 1;
      end;
   end Read_Field_Declaration;

   procedure Read_Field_Data (State : Skill_State) is
   begin
      for I in 1 .. State.instancesCount loop
         case State.fieldType is
            when 7 => Ada.Text_IO.Put_Line (i8'Image (Byte_Reader.Read_i8));
            when 11 => Ada.Text_IO.Put_Line (v64'Image (Byte_Reader.Read_v64));
            when others => null;
         end case;
      end loop;
   end Read_Field_Data;

end Date.Internal.File_Parser;

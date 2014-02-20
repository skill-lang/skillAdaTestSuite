package body Node.Internal.File_Parser is

   package Byte_Reader renames Node.Internal.Byte_Reader;

   State : access Serializable_State;

   procedure Read (pState : access Serializable_State; File_Name : String) is
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
   begin
      if (not State.Has_Type_Declaration (Type_Name)) then
         State.Put_Type_Declaration (Type_Name, Byte_Reader.Read_v64);
         Instances_Count := Byte_Reader.Read_v64;
         --  skip restrictions
         declare skip_restrictions : Long := Byte_Reader.Read_v64; begin null; end;
      else
         Instances_Count := Byte_Reader.Read_v64;
      end if;

      --  DATA CHUNKS - TODO ???

      declare
         Field_Count : Long := Byte_Reader.Read_v64;
         Known_Fields : Long := State.Get_Known_Fields (Type_Name);
      begin
         for I in 1 .. Field_Count loop
            if Field_Count > Known_Fields then
               Read_Field_Declaration (Type_Name);
            end if;

            declare Offset : Long := Byte_Reader.Read_v64; begin null; end;
         end loop;
      end;
   end Read_Type_Declaration;

   procedure Read_Field_Declaration (Type_Name : String) is
   begin
      --  skip restrictions
      declare skip_restrictions : Long := Byte_Reader.Read_v64; begin null; end;

      declare
         Field_Type : Short_Short_Integer := Byte_Reader.Read_i8;
         Field_Name : String := State.Get_String (Byte_Reader.Read_v64);
      begin
         State.Put_Field_Declaration (Type_Name, Field_Name, Field_Type);
      end;
   end Read_Field_Declaration;

   procedure Read_Field_Data is
      X : i8 := Byte_Reader.Read_i8;
      Y : i8 := Byte_Reader.Read_i8;
   begin
      Ada.Text_IO.Put_Line (X'Img);
      Ada.Text_IO.Put_Line (Y'Img);
   end Read_Field_Data;

end Node.Internal.File_Parser;

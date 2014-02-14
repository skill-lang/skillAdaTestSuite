package body Date.Api.Skill_State is

   procedure Read (File_Name : String) is
      A : Date_Type := (Date => 5);
      B : Date_Type := (Date => -5);
      Dates : array (1 .. 2) of Date_Type;
   begin
      Date.Internal.File_Parser.Read (File_Name);

      Ada.Text_IO.New_Line;

      Dates (1) := A;
      Dates (2) := B;

      for I in Dates'Range loop
         Ada.Text_IO.Put_Line (Long'Image (Dates (I).Date));
      end loop;
   end Read;

   procedure Write (File_Name : String) is
   begin
      null;
   end;

end Date.Api.Skill_State;

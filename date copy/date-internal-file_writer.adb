--  ___ _  ___ _ _                                                            --
-- / __| |/ (_) | |       Your SKilL Ada Binding                              --
-- \__ \ ' <| | | |__     <<debug>>                                           --
-- |___/_|\_\_|_|____|    by: <<some developer>>                              --
--                                                                            --

package body Date.Internal.File_Writer is

   State : access Skill_State;

   procedure Write (pState : access Skill_State; File_Name : String) is
      Output_File : ASS_IO.File_Type;
   begin
      State := pState;

      ASS_IO.Create (Output_File, ASS_IO.Out_File, File_Name);
      Byte_Writer.Initialize (ASS_IO.Stream (Output_File));

      Write_String_Pool;

      ASS_IO.Close (Output_File);
   end Write;

   procedure Write_String_Pool is
      Size : Natural := State.String_Pool_Size;
      Last_Length : Natural := 0;
   begin
      Byte_Writer.Write_v64 (Long (Size));

      for I in 1 .. Size loop
         declare
            Length : Positive := State.Get_String (I)'Length + Last_Length;
         begin
            Byte_Writer.Write_i32 (Length);
            Last_Length := Length;
         end;
      end loop;

      for I in 1 .. Size loop
         Byte_Writer.Write_String (State.Get_String (I));
      end loop;
   end Write_String_Pool;

end Date.Internal.File_Writer;

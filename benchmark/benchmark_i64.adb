with Date;
with Date.Api.Skill;
with Date.Internal.Byte_Writer;
with Date.Internal.Byte_Reader;

package body Benchmark_I64 is

   procedure Write (N : Long; File_Name : String) is
      package Byte_Writer renames Date.Internal.Byte_Writer;

      Output_File : ASS_IO.File_Type;
      Output_Stream : ASS_IO.Stream_Access;
   begin
      ASS_IO.Create (Output_File, ASS_IO.Out_File, File_Name);
      Output_Stream := ASS_IO.Stream (Output_File);

      for I in 1 .. N loop
         Byte_Writer.Write_i64 (Output_Stream, I);
      end loop;

      Byte_Writer.Finalize_Buffer (Output_Stream);

      ASS_IO.Close (Output_File);
   end Write;

   procedure Read (N : Long; File_Name : String) is
      package Byte_Reader renames Date.Internal.Byte_Reader;

      Input_File : ASS_IO.File_Type;
      Input_Stream : ASS_IO.Stream_Access;
   begin
      ASS_IO.Open (Input_File, ASS_IO.In_File, File_Name);
      Input_Stream := ASS_IO.Stream (Input_File);

      while not ASS_IO.End_Of_File (Input_File) or else not Byte_Reader.End_Of_Buffer loop
         declare
            X : Long := Byte_Reader.Read_i64 (Input_Stream);
         begin
            null;
         end;
      end loop;

      ASS_IO.Close (Input_File);
   end Read;

end Benchmark_I64;

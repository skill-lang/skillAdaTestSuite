with Byte_Writer;
with Byte_Reader;

package body Benchmark_V64 is

   procedure Write (N : Long; File_Name : String) is
      Output_File : ASS_IO.File_Type;
      Output_Stream : ASS_IO.Stream_Access;
   begin
      ASS_IO.Create (Output_File, ASS_IO.Out_File, File_Name);
      Output_Stream := ASS_IO.Stream (Output_File);

      declare
         use Byte_Writer;
      begin
         for I in 1 .. i64 (N) loop
            Write_v64 (Output_Stream, I);
         end loop;
      end;

      Byte_Writer.Finalize_Buffer (Output_Stream);

      ASS_IO.Close (Output_File);
   end Write;

   procedure Read (N : Long; File_Name : String) is
      Input_File : ASS_IO.File_Type;
      Input_Stream : ASS_IO.Stream_Access;
   begin
      ASS_IO.Open (Input_File, ASS_IO.In_File, File_Name);
      Input_Stream := ASS_IO.Stream (Input_File);

      declare
         use Byte_Reader;
      begin
         while not ASS_IO.End_Of_File (Input_File) or else not End_Of_Buffer loop
            declare
               X : v64 := Read_v64 (Input_Stream);
            begin
               null;
            end;
         end loop;
      end;

      ASS_IO.Close (Input_File);
   end Read;

end Benchmark_V64;

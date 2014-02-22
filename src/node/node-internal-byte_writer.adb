package body Node.Internal.Byte_Writer is

   Output_Stream : ASS_IO.Stream_Access;

   procedure Initialize (pOutput_Stream : ASS_IO.Stream_Access) is
   begin
      Output_Stream := pOutput_Stream;
   end Initialize;

   procedure Write_Byte (Next : Byte) is
   begin
      Byte'Write (Output_Stream, Next);
   end Write_Byte;

   procedure Write_i8 (Value : i8) is
      function Convert is new Ada.Unchecked_Conversion (Source => i8, Target => Byte);
   begin
      Write_Byte (Convert (Value));
   end Write_i8;

   procedure Write_i16 (Value : i16) is
      type Result is mod 2 ** 16;
      function Convert is new Ada.Unchecked_Conversion (Source => i16, Target => Result);

      A : Result := (Convert (Value) / (2 ** 8)) and 16#ff#;
      B : Result := Convert (Value) and 16#ff#;
   begin
      Write_Byte (Byte (A));
      Write_Byte (Byte (B));
   end Write_i16;

   procedure Write_i32 (Value : i32) is
      type Result is mod 2 ** 32;
      function Convert is new Ada.Unchecked_Conversion (Source => i32, Target => Result);

      A : Result := (Convert (Value) / (2 ** 24)) and 16#ff#;
      B : Result := (Convert (Value) / (2 ** 16)) and 16#ff#;
      C : Result := (Convert (Value) / (2 ** 8)) and 16#ff#;
      D : Result := Convert (Value) and 16#ff#;
   begin
      Write_Byte (Byte (A));
      Write_Byte (Byte (B));
      Write_Byte (Byte (C));
      Write_Byte (Byte (D));
   end Write_i32;

   procedure Write_i64 (Value : i64) is
      type Result is mod 2 ** 64;
      function Convert is new Ada.Unchecked_Conversion (Source => i64, Target => Result);

      A : Result := (Convert (Value) / (2 ** 56)) and 16#ff#;
      B : Result := (Convert (Value) / (2 ** 48)) and 16#ff#;
      C : Result := (Convert (Value) / (2 ** 40)) and 16#ff#;
      D : Result := (Convert (Value) / (2 ** 32)) and 16#ff#;
      E : Result := (Convert (Value) / (2 ** 24)) and 16#ff#;
      F : Result := (Convert (Value) / (2 ** 16)) and 16#ff#;
      G : Result := (Convert (Value) / (2 ** 8)) and 16#ff#;
      H : Result := Convert (Value) and 16#ff#;
   begin
      Write_Byte (Byte (A));
      Write_Byte (Byte (B));
      Write_Byte (Byte (C));
      Write_Byte (Byte (D));
      Write_Byte (Byte (E));
      Write_Byte (Byte (F));
      Write_Byte (Byte (G));
      Write_Byte (Byte (H));
   end Write_i64;

   procedure Write_v64 (Value : v64) is
      rval : Byte_v64_Type := Get_v64_Bytes (Value);
   begin
      for I in rval'Range loop
         Write_Byte (rval (I));
      end loop;
   end Write_v64;

   function Get_v64_Bytes (Value : v64) return Byte_v64_Type is
      Size : Natural := 0;
   begin
      declare
         type Result is mod 2 ** 64;
         function Convert is new Ada.Unchecked_Conversion (Source => v64, Target => Result);

         Buckets : Result := Convert (Value);
      begin
         while (Buckets > 0) loop
            Buckets := Buckets / (2 ** 7);
            Size := Size + 1;
         end loop;
      end;

      case Size is
         when 0 => return (0 => 0);
         when 10 => Size := 9;
         when others => null;
      end case;

      declare
         type Result is mod 2 ** 64;
         function Convert is new Ada.Unchecked_Conversion (Source => v64, Target => Result);

         rval : Byte_v64_Type (0 .. Size - 1);
         Count : Natural := 0;
      begin
         while (Count < 8 and then Count < Size - 1) loop
            rval (Count) := Byte (((Convert (Value) / (2 ** (7 * Count))) or 16#80#) and 16#ff#);
            Count := Count + 1;
         end loop;
         rval (Count) := Byte ((Convert (Value) / (2 ** (7 * Count))) and 16#ff#);
         return rval;
      end;
   end Get_v64_Bytes;

   procedure Write_f32 (Value : f32) is
      Skill_Unsupported_Type : exception;
   begin
      raise Skill_Unsupported_Type;
   end Write_f32;

   procedure Write_f64 (Value : f64) is
      Skill_Unsupported_Type : exception;
   begin
      raise Skill_Unsupported_Type;
   end Write_f64;

   procedure Write_Boolean (Value : Boolean) is
   begin
      case Value is
         when True => Write_Byte (16#ff#);
         when False => Write_Byte (16#00#);
      end case;
      Ada.Text_IO.Put_Line (Boolean'Image (Value));
   end Write_Boolean;

   procedure Write_String (Value : String) is
   begin
      for I in Value'Range loop
         Write_Byte (Byte (Character'Pos (Value (I))));
      end loop;
   end Write_String;

end Node.Internal.Byte_Writer;

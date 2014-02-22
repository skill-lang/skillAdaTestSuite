package body Node is

   protected body Skill_State is

      -------------------
      --  STRING POOL  --
      -------------------
      function Get_String (Position : Long) return String is
         (String_Pool.Element (Positive (Position)));

      procedure Put_String (Value : String) is
      begin
         String_Pool.Append (Value);
      end Put_String;

      --------------------
      --  STORAGE_POOL  --
      --------------------
      function Get (Type_Name : String; Position : Positive) return Object'Class is
         A_Type : Type_Information := Get_Type (Type_Name);
      begin
         return A_Type.Storage_Pool.Element (Position);
      end Get;

      function Length (Type_Name : String) return Natural is
         A_Type : Type_Information := Get_Type (Type_Name);
      begin
         return Natural (A_Type.Storage_Pool.Length);
      end;

      procedure Put (Type_Name : String; New_Object : Object'Class) is
         A_Type : Type_Information := Get_Type (Type_Name);
      begin
         A_Type.Storage_Pool.Append (New_Object);
      end Put;

      --------------------------
      --  FIELD DECLARATIONS  --
      --------------------------
      function Known_Fields (Name : String) return Long is
         (Long (Types.Element (Name).Fields.Length));

      function Get_Field (Type_Name : String; Position : Long) return Field_Information is
         X : Type_Information := Get_Type (Type_Name);
      begin
         return X.Fields.Element (Positive (Position));
      end Get_Field;

      procedure Put_Field (Type_Name : String; New_Field : Field_Information) is
         Type_Declaration : Type_Information := Types.Element (Type_Name);
      begin
         Type_Declaration.Fields.Append (New_Field);
      end Put_Field;

      --------------------------
      --  TYPES DECLARATIONS  --
      --------------------------
      function Has_Type (Name : String) return Boolean is
      begin
         return Types.Contains (Name);
      end Has_Type;

      function Get_Type (Name : String) return Type_Information is
      begin
         return Types.Element (Name);
      end Get_Type;

      procedure Put_Type (New_Type : Type_Information) is
      begin
         Types.Insert (New_Type.Name, New_Type);
      end Put_Type;

   end Skill_State;

end Node;

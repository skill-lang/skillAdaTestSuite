package body Node is

   protected body Serializable_State is

      -------------------
      --  STRING POOL  --
      -------------------

      function Get_String (Position : Long) return String is
      begin
         return String_Pool.Element (Positive (Position));
      end Get_String;

      procedure Put_String (Value : String) is
      begin
         String_Pool.Append (Value);
      end Put_String;

      --------------------------
      --  TYPES DECLARATIONS  --
      --------------------------

      function Has_Type_Declaration (Value : String) return Boolean is
      begin
         return Type_Declarations.Contains (Value);
      end Has_Type_Declaration;

      procedure Put_Type_Declaration (Name : String; Super : Long) is
         Type_Declaration : Type_Declaration_Access;
         Fields : Field_Declaration_Vector.Vector;
      begin
         Type_Declaration := new Type_Declaration_Type'(Name'Length, Name, Super, Fields);
         Type_Declarations.Insert (Name, Type_Declaration);
      end Put_Type_Declaration;

      --------------------------
      --  FIELD DECLARATIONS  --
      --------------------------

      function Get_Known_Fields (Name : String) return Long is
      begin
         return Long (Type_Declarations.Element (Name).Type_Fields.Length);
      end Get_Known_Fields;

      procedure Put_Field_Declaration (Type_Name, Field_Name : String; Field_Type : Short_Short_Integer) is
         Field_Declaration : Field_Declaration_Access;
         Type_Declaration : Type_Declaration_Access := Type_Declarations.Element (Type_Name);
      begin
         Field_Declaration := new Field_Declaration_Type'(Field_Name'Length, Field_Name, Field_Type);
         Type_Declaration.Type_Fields.Append (Field_Declaration);
      end Put_Field_Declaration;

   end Serializable_State;

end Node;

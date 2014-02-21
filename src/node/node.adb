package body Node is

   protected body Skill_State is

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
         return Types.Contains (Value);
      end Has_Type_Declaration;

      procedure Put_Type_Declaration (Name : String; Super : Long) is
         Fields : Field_Declaration_Vector.Vector;
         Storage : Storage_Pool_Vector.Vector;
         X : Type_Information := new Type_Declaration'(Name'Length, Name, Super, Fields, Storage);
      begin
         Types.Insert (Name, X);
      end Put_Type_Declaration;

      --------------------------
      --  FIELD DECLARATIONS  --
      --------------------------
      function Get_Known_Fields (Name : String) return Long is
      begin
         return Long (Types.Element (Name).Fields.Length);
      end Get_Known_Fields;

      procedure Put_Field_Declaration (Type_Name, Field_Name : String; Field_Type : Short_Short_Integer) is
         X : Field_Information := new Field_Declaration'(Field_Name'Length, Field_Name, Field_Type);
         Type_Declaration : Type_Information := Types.Element (Type_Name);
      begin
         Type_Declaration.Fields.Append (X);
      end Put_Field_Declaration;

      procedure Put (X : Object'Class) is
      begin
         Storage_Pool.Append (New_Item => X);
      end Put;

   end Skill_State;

end Node;

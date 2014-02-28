package body Unknown.Test.Parse is

   package Skill renames Unknown.Api.Skill;
   use Unknown;
   use Skill;

   procedure Initialize (T : in out Test) is
   begin
      Set_Name (T, "Unknown.Test.Parse");
      Ahven.Framework.Add_Test_Routine (T, Check_Types'Access, "unknownSubtypes read");
      Ahven.Framework.Add_Test_Routine (T, Check_Fields_A'Access, "a: all fields are self-references");
      Ahven.Framework.Add_Test_Routine (T, Check_Fields_C'Access, "c: all fields are self-references");

      Skill.Read (T.State, "resources/localBasePoolStartIndex.sf");
   end Initialize;

   procedure Check_Types (T : in out Ahven.Framework.Test_Case'Class) is
      use Ada.Characters.Handling;
      use Ada.Strings.Fixed;
      use Ada.Tags;

      X : A_Type_Accesses := Skill.Get_As (Test (T).State);
      Types : constant String := "aaaaacaaaaaca";
   begin
      for I in Types'Range loop
         declare
            C : Character := To_Lower (Expanded_Name (Skill_Type_Access (X (I))'Tag)(9));
         begin
            Ahven.Assert (C = Types (I), "index " & Trim (I'Img, Ada.Strings.Left));
         end;
      end loop;
   end Check_Types;

   procedure Check_Fields_A (T : in out Ahven.Framework.Test_Case'Class) is
      use Ada.Strings.Fixed;

      X : A_Type_Accesses := Skill.Get_As (Test (T).State);
   begin
      for I in X'Range loop
         Ahven.Assert (X (I) = A_Type_Access (X (I).a), "index " & Trim (I'Img, Ada.Strings.Left));
      end loop;
   end Check_Fields_A;

   procedure Check_Fields_C (T : in out Ahven.Framework.Test_Case'Class) is
      use Ada.Strings.Fixed;

      X : C_Type_Accesses := Skill.Get_Cs (Test (T).State);
   begin
      for I in X'Range loop
         Ahven.Assert (X (I) = C_Type_Access (X (I).c), "index " & Trim (I'Img, Ada.Strings.Left));
      end loop;
   end Check_Fields_C;

end Unknown.Test.Parse;

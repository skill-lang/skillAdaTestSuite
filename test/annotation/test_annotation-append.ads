with Ada.Directories;
with Ahven.Framework;
with Annotation.Api;

package Test_Annotation.Append is

   package Skill renames Annotation.Api;
   use Annotation;
   use Annotation.Api;

   type Test is new Ahven.Framework.Test_Case with null record;

   procedure Initialize (T : in out Test);

   procedure Set_Up (T : in out Test);
   procedure Tear_Down (T : in out Test);

   procedure Append_Test_1 (T : in out Ahven.Framework.Test_Case'Class);
   procedure Append_Test_2 (T : in out Ahven.Framework.Test_Case'Class);
   procedure Append_Test_3 (T : in out Ahven.Framework.Test_Case'Class);

end Test_Annotation.Append;

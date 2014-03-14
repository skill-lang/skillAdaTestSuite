with Ada.Directories;
with Ahven.Framework;
with Annotation.Api.Skill;

package Test_Annotation.Write is

   package Skill renames Annotation.Api.Skill;
   use Annotation;
   use Skill;

   type Test is new Ahven.Framework.Test_Case with null record;

   procedure Initialize (T : in out Test);

   procedure Set_Up (T : in out Test);
   procedure Tear_Down (T : in out Test);

   procedure Read_And_Write (T : in out Ahven.Framework.Test_Case'Class);
   procedure Check_Annotation (T : in out Ahven.Framework.Test_Case'Class);
   procedure Annotation_Type_Safety (T : in out Ahven.Framework.Test_Case'Class);

end Test_Annotation.Write;

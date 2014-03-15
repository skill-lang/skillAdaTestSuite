with Ada.Directories;
with Ahven.Framework;
with Annotation.Api.Skill;

package Test_Null_Annotation.Write is

   package Skill renames Annotation.Api.Skill;
   use Annotation;
   use Skill;

   type Test is new Ahven.Framework.Test_Case with null record;

   procedure Initialize (T : in out Test);

   procedure Set_Up (T : in out Test);
   procedure Tear_Down (T : in out Test);

   procedure Read_Written (T : in out Ahven.Framework.Test_Case'Class);
   procedure Null_Annotation (T : in out Ahven.Framework.Test_Case'Class);

end Test_Null_Annotation.Write;

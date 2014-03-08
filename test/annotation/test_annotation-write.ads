with Ahven.Framework;
with Annotation.Api.Skill;

package Test_Annotation.Write is

   package Skill renames Annotation.Api.Skill;
   use Annotation;
   use Skill;

   type Test is new Ahven.Framework.Test_Case with null record;

   procedure Initialize (T : in out Test);

   procedure Read_And_Write;
   procedure Check_Annotation;
   procedure Annotation_Type_Safety;

end Test_Annotation.Write;

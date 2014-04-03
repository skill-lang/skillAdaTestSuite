with Ahven.Framework;
with Annotation.Api;

package Test_Annotation.Read is

   package Skill renames Annotation.Api;
   use Annotation;
   use Annotation.Api;

   type Test is new Ahven.Framework.Test_Case with null record;

   procedure Initialize (T : in out Test);

   procedure Check_Annotation;
   procedure Change_Annotation;
   procedure Annotation_Type_Safety;

end Test_Annotation.Read;

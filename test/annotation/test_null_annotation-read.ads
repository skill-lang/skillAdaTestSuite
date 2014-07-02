with Ahven.Framework;
with Annotation.Api;

package Test_Null_Annotation.Read is

   package Skill renames Annotation.Api;
   use Annotation;
   use Annotation.Api;

   type Test is new Ahven.Framework.Test_Case with null record;

   procedure Initialize (T : in out Test);

   procedure Null_Annotation (T : in out Ahven.Framework.Test_Case'Class);

end Test_Null_Annotation.Read;

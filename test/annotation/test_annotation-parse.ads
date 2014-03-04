with Ahven.Framework;
with Annotation.Api.Skill;

package Test_Annotation.Parse is

   package Skill renames Annotation.Api.Skill;
   use Annotation;
   use Skill;

   type Test is new Ahven.Framework.Test_Case with record
      State : access Skill_State := new Skill_State;
   end record;

   procedure Initialize (T : in out Test);

   procedure Check_Annotation (T : in out Ahven.Framework.Test_Case'Class);
   procedure Change_Annotation (T : in out Ahven.Framework.Test_Case'Class);
   procedure Annotation_Type_Safety (T : in out Ahven.Framework.Test_Case'Class);

end Test_Annotation.Parse;

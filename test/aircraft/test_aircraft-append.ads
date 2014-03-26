with Ada.Directories;
with Ada.Strings.Unbounded;
with Ada.Tags;
with Ahven.Framework;
with Aircraft.Api.Skill;

package Test_Aircraft.Append is

   package Skill renames Aircraft.Api.Skill;
   use Aircraft;
   use Skill;

   type Test is new Ahven.Framework.Test_Case with null record;

   procedure Initialize (T : in out Test);

   procedure Set_Up (T : in out Test);
   procedure Tear_Down (T : in out Test);

   procedure Create_Write_Read_Append_Write_Read (T : in out Ahven.Framework.Test_Case'Class);
   procedure Check_Tags_After_Append (T : in out Ahven.Framework.Test_Case'Class);

end Test_Aircraft.Append;

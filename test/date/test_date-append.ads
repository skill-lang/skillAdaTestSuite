with Ada.Directories;
with Ahven.Framework;
with Date.Api.Skill;

package Test_Date.Append is

   package Skill renames Date.Api.Skill;
   use Date;
   use Skill;

   type Test is new Ahven.Framework.Test_Case with null record;

   procedure Initialize (T : in out Test);

   procedure Set_Up (T : in out Test);
   procedure Tear_Down (T : in out Test);

   procedure Read_Append_Read (T : in out Ahven.Framework.Test_Case'Class);
   procedure Create_Write_4xAppend_Read (T : in out Ahven.Framework.Test_Case'Class);

end Test_Date.Append;

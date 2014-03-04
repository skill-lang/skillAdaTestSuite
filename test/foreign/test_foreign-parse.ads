with Ada.Characters.Handling;
with Ada.Strings.Fixed;
with Ada.Tags;
with Ahven.Framework;
with Unknown;
with Unknown.Api.Skill;

package Test_Foreign.Parse is

   type Test is new Ahven.Framework.Test_Case with null record;

   procedure Initialize (T : in out Test);

   procedure Aircraft;
   procedure Annotation_Test;
   procedure Constant_Maybe_Wrong;
   procedure Container;
   procedure Date_Example;
   procedure Local_Base_Pool_Start_Index;
   procedure Node;
   procedure Two_Node_Blocks;

end Test_Foreign.Parse;

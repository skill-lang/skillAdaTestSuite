with Ahven.Framework;
with Unknown.Api;

package Test_Foreign.Read is

   package Skill renames Unknown.Api;
   use Unknown;
   use Unknown.Api;

   type Test is new Ahven.Framework.Test_Case with null record;

   procedure Initialize (T : in out Test);

   procedure Aircraft;
   procedure Annotation_Test;
   procedure Colored_Nodes;
   procedure Constant_Maybe_Wrong;
   procedure Container;
   procedure Date_Example;
   procedure Four_Colored_Nodes;
   procedure Local_Base_Pool_Start_Index;
   procedure Node;
   procedure Null_Annotation;
   procedure Two_Node_Blocks;

end Test_Foreign.Read;

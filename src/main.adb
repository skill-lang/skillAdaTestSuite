with Date.Api.Skill_State;

procedure Main is
   use Date.Api;
begin
--   Skill_State.Read ("resources/date-example.sf");
--   Skill_State.Read ("resources/twoNodeBlocks.sf");

   Skill_State.Write ("zzz-test-ada.sf");
   Skill_State.Read ("zzz-test-ada.sf");
end Main;

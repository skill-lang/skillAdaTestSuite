with Date.Api.Skill_State;

procedure Main is
   use Date.Api;
begin
   Skill_State.Read ("resources/date-example.sf");
--   Skill_State.Read ("resources/twoNodeBlocks.sf");
end Main;

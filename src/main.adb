with Date.Api.Skill_State;

procedure Main is
   use Date.Api;
begin
   Skill_State.Read ("resources/date-example.sf");

--   Skill_State.Write ("zzz-ada-test.sf");
--   Skill_State.Read ("zzz-ada-test.sf");
end Main;

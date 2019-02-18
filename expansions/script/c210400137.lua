--created & coded by Lyris
--襲雷ストアイク
local function getID()
	local str=string.match(debug.getinfo(2,'S')['source'],"c%d+%.lua")
	str=string.sub(str,1,string.len(str)-4)
	local cod=_G[str]
	local id=tonumber(string.sub(str,2))
	return id,cod
end
local id,cid=getID()
function cid.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCategory(CATEGORY_DESTROY)
	c:RegisterEffect(e1)
end
function cid.cfilter(c)
	return c:IsSetCard(0x7c4) and c:IsDestructable()
end
function cid.penfilter(c)
	return c:IsSetCard(0x7c4) and c:IsType(TYPE_PENDULUM) and not c:IsForbidden()
end
function cid.pentg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(cid.cfilter,tp,LOCATION_PZONE,0,1,nil)
		and Duel.IsExistingMatchingCard(cid.penfilter,tp,LOCATION_DECK,0,1,nil) end
	local g=Duel.GetMatchingGroup(cid.cfilter,tp,LOCATION_PZONE,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function cid.penop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local dg=Duel.SelectMatchingCard(tp,cid.cfilter,tp,LOCATION_PZONE,0,1,1,nil)
	if dg:GetCount()>0 then
		if Duel.Destroy(dg,REASON_EFFECT)==0 then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
		local g=Duel.SelectMatchingCard(tp,cid.penfilter,tp,LOCATION_DECK,0,1,1,nil)
		local tc=g:GetFirst()
		if tc then
			Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		end
	end
end

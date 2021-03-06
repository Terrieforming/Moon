--Spell-Form-Summoner Apprentice
function c249000473.initial_effect(c)
	c:EnableCounterPermit(0x48)
	aux.EnablePendulumAttribute(c)
	--add counter spell activation
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e1:SetCode(EVENT_CHAIN_SOLVING)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetRange(LOCATION_MZONE)
	e1:SetOperation(c249000473.acop)
	c:RegisterEffect(e1)
	--spsummon create
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetDescription(1063)
	e2:SetCountLimit(1,2490004731)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c249000473.spcon)
	e2:SetCost(c249000473.spcost)
	e2:SetTarget(c249000473.sptg)
	e2:SetOperation(c249000473.spop)
	c:RegisterEffect(e2)
	--add counter monster effect activation
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e3:SetCode(EVENT_CHAIN_SOLVING)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetRange(LOCATION_PZONE)
	e3:SetCountLimit(5,2490004732)
	e3:SetOperation(c249000473.acop2)
	c:RegisterEffect(e3)
	--destroy replace
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetCode(EFFECT_DESTROY_REPLACE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTarget(c249000473.reptg)
	c:RegisterEffect(e4)
	--spsummon hand/deck
	local e5=Effect.CreateEffect(c)
	e5:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetDescription(1000)
	e5:SetCountLimit(1,2490004733)
	e5:SetRange(LOCATION_MZONE)
	e5:SetTarget(c249000473.sptg2)
	e5:SetOperation(c249000473.spop2)
	c:RegisterEffect(e5)
end
function c249000473.acop(e,tp,eg,ep,ev,re,r,rp)
	if re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:IsActiveType(TYPE_SPELL) then
		e:GetHandler():AddCounter(0x48,2)
	end
end
function c249000473.confilter(c)
	return c:IsSetCard(0x1C1) and not c:IsCode(249000473)  and (c:IsFaceup() or c:IsLocation(LOCATION_GRAVE))
end
function c249000473.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c249000473.confilter,tp,LOCATION_ONFIELD+LOCATION_GRAVE,0,1,nil)
end
function c249000473.costfilter(c)
	return c:IsAbleToRemoveAsCost()and c:IsType(TYPE_MONSTER)
end
function c249000473.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsCanRemoveCounter(tp,1,0,0x48,3,REASON_COST)
		and Duel.IsExistingMatchingCard(c249000473.costfilter,tp,LOCATION_GRAVE+LOCATION_HAND,0,1,nil) end
	local spct=Duel.GetCounter(tp,1,0,0x48)
	if spct>9 then spct=9 end
	local spt={}
	local i
	for i=3,spct do
		spt[i-3]=i
	end
	local lv=Duel.AnnounceNumber(tp,table.unpack(spt))
	if lv<=3 then
		Duel.RemoveCounter(tp,1,0,0x48,3,REASON_COST)
	else
		Duel.RemoveCounter(tp,1,0,0x48,lv,REASON_COST)
	end
	e:SetLabel(lv)
	local g=Duel.SelectMatchingCard(tp,c249000473.costfilter,tp,LOCATION_GRAVE+LOCATION_HAND,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
	e:SetLabelObject(g:GetFirst())
end
function c249000473.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c249000473.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local lv=e:GetLabel()
	local tc=e:GetLabelObject()
	local ac=Duel.AnnounceCardFilter(tp,tc:GetOriginalRace(),OPCODE_ISRACE,tc:GetOriginalAttribute(),OPCODE_ISATTRIBUTE,OPCODE_AND,TYPE_XYZ+TYPE_SYNCHRO,OPCODE_ISTYPE,OPCODE_AND,c:GetOriginalCode(),OPCODE_ISCODE,OPCODE_OR)
	if ac==c:GetCode() then return end
	local cc=Duel.CreateToken(tp,ac)	
	while not (cc:IsType(TYPE_MONSTER) and cc:IsCanBeSpecialSummoned(e,0,tp,true,false) and cc:IsRace(tc:GetRace()) and cc:IsAttribute(tc:GetAttribute())
	and cc:GetCode()~=tc:GetCode()	and ((cc:IsType(TYPE_SYNCHRO) and cc:GetLevel()==lv) or (cc:IsType(TYPE_XYZ) and cc:GetRank()==lv)))
	do
		ac=Duel.AnnounceCardFilter(tp,tc:GetOriginalRace(),OPCODE_ISRACE,tc:GetOriginalAttribute(),OPCODE_ISATTRIBUTE,OPCODE_AND,TYPE_XYZ+TYPE_SYNCHRO,OPCODE_ISTYPE,OPCODE_AND,c:GetOriginalCode(),OPCODE_ISCODE,OPCODE_OR)
		if ac==c:GetCode() then return end
		cc=Duel.CreateToken(tp,ac)
	end
	if cc:IsType(TYPE_SYNCHRO) then	Duel.SpecialSummon(cc,0,tp,tp,true,false,POS_FACEUP)
	elseif cc:IsType(TYPE_XYZ) and Duel.SpecialSummon(cc,0,tp,tp,true,false,POS_FACEUP) then
		local tc2=Duel.GetFieldCard(tp,LOCATION_GRAVE,Duel.GetFieldGroupCount(tp,LOCATION_GRAVE,0)-1)
		if tc2 then
			Duel.Overlay(cc,tc2)
		end
	end
end
function c249000473.pfilter(c)
	return c:IsFaceup() and c:IsCanAddCounter(0x48,1)
end
function c249000473.acop2(e,tp,eg,ep,ev,re,r,rp)
	if re:IsActiveType(TYPE_MONSTER) then
		local g=Duel.SelectMatchingCard(tp,c249000473.pfilter,tp,LOCATION_ONFIELD,0,1,1,nil)
		if g:GetCount() > 0 then
			g:GetFirst():AddCounter(0x48,1)
		end
	end
end
function c249000473.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not e:GetHandler():IsReason(REASON_RULE)
		and e:GetHandler():IsCanRemoveCounter(tp,0x48,1,REASON_COST) end
	e:GetHandler():RemoveCounter(tp,0x48,1,REASON_EFFECT)
	return true
end
function c249000473.filter(c,cc,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and c:GetLevel()>2 and c:GetLevel()<10 and Duel.IsCanRemoveCounter(tp,1,0,0x48,c:GetLevel(),REASON_COST)
end
function c249000473.sptg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c249000473.filter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e:GetHandler(),e,tp) end
	local g=Duel.GetMatchingGroup(c249000473.filter,tp,LOCATION_HAND+LOCATION_DECK,0,nil,e:GetHandler(),e,tp)
	local lvt={}
	local tc=g:GetFirst()
	while tc do
		local tlv=tc:GetLevel()
		lvt[tlv]=tlv
		tc=g:GetNext()
	end
	local pc=1
	for i=1,12 do
		if lvt[i] then lvt[i]=nil lvt[pc]=i pc=pc+1 end
	end
	lvt[pc]=nil
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(249000473,1))
	local lv=Duel.AnnounceNumber(tp,table.unpack(lvt))
	Duel.RemoveCounter(tp,1,0,0x48,lv,REASON_COST)
	e:SetLabel(lv)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
end
function c249000473.sfilter(c,lv,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and c:IsLevel(lv)
end
function c249000473.spop2(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local lv=e:GetLabel()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c249000473.sfilter),tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,lv,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end

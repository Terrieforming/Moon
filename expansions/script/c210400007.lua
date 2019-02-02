--created & coded by Lyris
--インライトメント・ケースト尻尾
function c210400007.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,1)
	e1:SetValue(c210400007.aclimit)
	e1:SetCondition(c210400007.actcon)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_BATTLED)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,210400007)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCategory(CATEGORY_REMOVE)
	e2:SetCondition(c210400007.descon)
	e2:SetTarget(c210400007.destg)
	e2:SetOperation(c210400007.desop)
	c:RegisterEffect(e2)
end
function c210400007.aclimit(e,re,tp)
	return not re:GetHandler():IsImmuneToEffect(e)
end
function c210400007.actcon(e)
	return Duel.GetAttacker()~=e:GetHandler() and Duel.GetAttacker():IsSetCard(0xda6)
end
function c210400007.descon(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if d and d:IsControler(tp) then a,d=d,a end
	return a:IsSetCard(0xda6) and a~=e:GetHandler()
end
function c210400007.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToRemove()
end
function c210400007.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local dir=Duel.GetAttackTarget()==nil
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) and c210400007.filter(chkc) end
	if chk==0 then return true end
	local max=1
	if dir then max=2 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,c210400007.filter,tp,0,LOCATION_ONFIELD,1,max,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,g:GetCount(),0,0)
end
function c210400007.desfilter(c,e,tp)
	return c:IsRelateToEffect(e) and c:IsControler(tp)
end
function c210400007.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if not g or g:GetCount()==0 then return end
	local rg=g:Filter(c210400007.desfilter,nil,e,1-tp)
	Duel.Remove(rg,POS_FACEUP,REASON_EFFECT)
end
--created & coded by Lyris
--インライトメント・エアリアル光
function c210400012.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0xda6))
	e1:SetValue(1)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_BATTLED)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,210400012)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCategory(CATEGORY_REMOVE)
	e2:SetCondition(c210400012.descon)
	e2:SetTarget(c210400012.destg)
	e2:SetOperation(c210400012.desop)
	c:RegisterEffect(e2)
end
function c210400012.descon(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if d and d:IsControler(tp) then a,d=d,a end
	return a:IsSetCard(0xda6) and a~=e:GetHandler()
end
function c210400012.filter(c)
	return c:IsFaceup() and c:GetAttack()>=1500 and c:IsAbleToRemove()
end
function c210400012.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local dir=Duel.GetAttackTarget()==nil
	if chkc then
		if dir then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp)
		else return chkc==Duel.GetAttacker():GetBattleTarget() end
	end
	if chk==0 then return true end
	local g=Group.FromCards(Duel.GetAttacker():GetBattleTarget())
	if dir then
		g=Duel.SelectMatchingCard(tp,aux.AND(Card.IsCanBeEffectTarget,c210400012.filter),tp,0,LOCATION_MZONE,1,1,nil,e)
	end
	Duel.SetTargetCard(g)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,g:GetCount(),0,0)
end
function c210400012.desop(e,tp,eg,ep,ev,re,r,rp)
	local dir=Duel.GetAttackTarget()==nil
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and (not dir or (tc:IsFaceup() and tc:GetAttack()>=1500)) and tc:IsControler(1-tp) then
		Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end
end
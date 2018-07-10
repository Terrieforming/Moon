--Subzero Crystal - Guardian Sorteactra
function c88890009.initial_effect(c)
    c:EnableReviveLimit()
    --(1) Special Summon condition
    local e1=Effect.CreateEffect(c)
    e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCode(EFFECT_SPSUMMON_CONDITION)
    e1:SetValue(c88890009.splimit)
    c:RegisterEffect(e1)
    --(2) Excavate
    --local e2=Effect.CreateEffect(c)
    --e2:SetDescription(aux.Stringid(88890009,0))
    --e2:SetCategory(CATEGORY_REMOVE)
    --e2:SetType(EFFECT_TYPE_SINGLE)
    --e2:SetCode(EVENT_FREE_CHAIN)
    --e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
    --e2:SetRange(LOCATION_MZONE)
    --e2:SetTarget(c88890009.rmtg)
    --e2:SetOperation(c88890009.rmop)
    --c:RegisterEffect(e2)
    --(3) Pay or Destroy
    local e3=Effect.CreateEffect(c)
    e3:SetDescription(aux.Stringid(88890009,1))
    e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
    e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
    e3:SetCode(EVENT_PHASE+PHASE_STANDBY)
    e3:SetRange(LOCATION_MZONE)
    e3:SetCountLimit(1)
    e3:SetCondition(c88890009.paycon)
    e3:SetOperation(c88890009.payop)
    c:RegisterEffect(e3)
    --(4) To hand
    local e4=Effect.CreateEffect(c)
    e4:SetDescription(aux.Stringid(88890009,2))
    e4:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
    e4:SetType(EFFECT_TYPE_IGNITION)
    e4:SetRange(LOCATION_HAND)
    e4:SetCost(c88890009.thcost)
    e4:SetTarget(c88890009.thtg)
    e4:SetOperation(c88890009.thop)
    c:RegisterEffect(e4)
    --(5) Place in S/T Zone
    local e5=Effect.CreateEffect(c)
    e5:SetType(EFFECT_TYPE_SINGLE)
    e5:SetCode(EFFECT_TO_GRAVE_REDIRECT_CB)
    e5:SetProperty(EFFECT_FLAG_UNCOPYABLE)
    e5:SetCondition(c88890009.stzcon)
    e5:SetOperation(c88890009.stzop)
    c:RegisterEffect(e5)
    --(6) can't normal summon
    local e6=Effect.CreateEffect(c)
    e6:SetType(EFFECT_TYPE_FIELD)
    e6:SetCode(EFFECT_CANNOT_SUMMON)
    e6:SetRange(LOCATION_SZONE)
    e6:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e6:SetTargetRange(0,1)
    e6:SetCondition(c88890009.efcon)
    e6:SetTarget(c88890009.efval)
    c:RegisterEffect(e6)
    --(7) add
    local e7=Effect.CreateEffect(c)
    e7:SetDescription(aux.Stringid(88890009,4))
    e7:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
    e7:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
    e7:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
    e7:SetCode(EVENT_TO_GRAVE)
    e7:SetCondition(c88890009.thcon)
    e7:SetTarget(c88890009.thtg1)
    e7:SetOperation(c88890009.thop1)
    c:RegisterEffect(e7)
end
--(1) Special Summon condition
function c88890009.splimit(e,se,sp,st)
    return se:GetHandler():IsSetCard(0x902)
end
--(3) Excavate
--function c88890009.rmtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
    --if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) end
    --if chk==0 then return Duel.IsExistingTarget(nil,tp,0,LOCATION_MZONE,1,nil) end
    --Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
    --Duel.SelectTarget(tp,nil,tp,0,LOCATION_MZONE,1,1,nil)
--end
--function c88890009.rmop(e,tp,eg,ep,ev,re,r,rp)
    --Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
    --local g=Duel.SelectMatchingCard(tp,c7445307.rmfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil,e:GetHandler():GetAttack())
    --if g:GetCount()>0 then
        --Duel.HintSelection(g)
        --Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
    --end
--end    
--(3) Pay or Destroy
function c88890009.paycon(e,tp,eg,ep,ev,re,r,rp)
    return Duel.GetTurnPlayer()==tp
end
function c88890009.payop(e,tp,eg,ep,ev,re,r,rp)
    Duel.HintSelection(Group.FromCards(e:GetHandler()))
    if Duel.CheckLPCost(tp,500) and Duel.SelectYesNo(tp,aux.Stringid(88890009,1)) then
        Duel.Hint(HINT_OPSELECTED,1-tp,aux.Stringid(88890009,5))
        Duel.PayLPCost(tp,500)
    else
        Duel.Hint(HINT_OPSELECTED,1-tp,aux.Stringid(88890009,6))
        Duel.Destroy(e:GetHandler(),REASON_COST)
    end
end
--(4) To hand
function c88890009.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return e:GetHandler():IsDiscardable() end
    Duel.SendtoGrave(e:GetHandler(),REASON_COST+REASON_DISCARD)
end
function c88890009.thfilter(c)
    return c:IsSetCard(0x902) and c:GetType()==TYPE_SPELL+TYPE_RITUAL and c:IsAbleToHand()
end
function c88890009.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(c88890009.thfilter,tp,LOCATION_DECK,0,1,nil) end
    Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
    Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c88890009.thop(e,tp,eg,ep,ev,re,r,rp)
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
    local g=Duel.SelectMatchingCard(tp,c88890009.thfilter,tp,LOCATION_DECK,0,1,1,nil)
    if g:GetCount()>0 then
        Duel.SendtoHand(g,nil,REASON_EFFECT)
        Duel.ConfirmCards(1-tp,g)
    end
end
--(5) Place in S/T Zone
function c88890009.stzcon(e)
    local c=e:GetHandler()
    return c:IsFaceup() and c:IsLocation(LOCATION_MZONE) and c:IsReason(REASON_DESTROY)
end
function c88890009.stzop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    --Continuous Spell
    local e1=Effect.CreateEffect(c)
    e1:SetCode(EFFECT_CHANGE_TYPE)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
    e1:SetReset(RESET_EVENT+0x1fc0000)
    e1:SetValue(TYPE_SPELL+TYPE_CONTINUOUS)
    c:RegisterEffect(e1)
    Duel.RaiseEvent(c,EVENT_CUSTOM+88890010,e,0,tp,0,0)
end
--(6) can't normal summon
function c88890009.efcon(e)
    return e:GetHandler():IsType(TYPE_SPELL+TYPE_CONTINUOUS) and e:GetHandler():IsFaceup() and not e:GetHandler():IsType(TYPE_EQUIP)
end
function c88890009.efval(e,c)
    return not c:IsAttribute(ATTRIBUTE_EARTH)
end
--(7) add
function c88890009.thcon(e,tp,eg,ep,ev,re,r,rp)
    return e:GetHandler():IsReason(REASON_EFFECT) and e:GetHandler():GetPreviousLocation()==LOCATION_DECK
end
function c88890009.thfilter1(c)
    return c:IsSetCard(0x902) and c:IsAbleToHand()
end
function c88890009.thtg1(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(c88890009.thfilter1,tp,LOCATION_DECK,0,1,nil) end
    Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
    Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c88890009.thop1(e,tp,eg,ep,ev,re,r,rp)
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
    local g=Duel.SelectMatchingCard(tp,c88890009.thfilter1,tp,LOCATION_DECK,0,1,1,nil)
    if g:GetCount()>0 then
        Duel.SendtoHand(g,nil,REASON_EFFECT)
        Duel.ConfirmCards(1-tp,g)
    end
end
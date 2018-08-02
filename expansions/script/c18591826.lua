--Anabela, The Princess Of The Assassins
function c18591826.initial_effect(c)
    --xyz summon
    aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x50e),4,3)
    c:EnableReviveLimit()
    --recover
    local e1=Effect.CreateEffect(c)
    e1:SetDescription(aux.Stringid(18591826,0))
    e1:SetCategory(CATEGORY_RECOVER)
    e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
    e1:SetCode(EVENT_BE_BATTLE_TARGET)
    e1:SetTarget(c18591826.rectg)
    e1:SetOperation(c18591826.recop)
    c:RegisterEffect(e1)
    --spsummon
    local e2=Effect.CreateEffect(c)
    e2:SetDescription(aux.Stringid(18591826,1))
    e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
    e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
    e2:SetCode(EVENT_DESTROYED)
    e2:SetCondition(c18591826.spcon)
    e2:SetTarget(c18591826.sptg)
    e2:SetOperation(c18591826.spop)
    c:RegisterEffect(e2)
end
function c18591826.rectg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return true end
    local tc=Duel.GetAttacker()
    tc:CreateEffectRelation(e)
    Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,tc:GetAttack()/2)
end
function c18591826.recop(e,tp,eg,ep,ev,re,r,rp)
    local tc=Duel.GetAttacker()
    if tc:IsRelateToEffect(e) and tc:IsFaceup() then
        Duel.Recover(tp,tc:GetAttack()/2,REASON_EFFECT)
    end
end
function c18591826.spcon(e,tp,eg,ep,ev,re,r,rp)
    return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c18591826.spfilter(c,e,tp)
    return c:IsCode(18591825) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c18591826.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
    if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c18591826.spfilter(chkc,e,tp) end
    if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
        and Duel.IsExistingTarget(c18591826.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
    local g=Duel.SelectTarget(tp,c18591826.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
    Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c18591826.spop(e,tp,eg,ep,ev,re,r,rp)
    local tc=Duel.GetFirstTarget()
    if tc:IsRelateToEffect(e) then
        Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
    end
end

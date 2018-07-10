--Kid Ninja - The Striker
function c18591879.initial_effect(c)
    --synchro summon
    aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsCode,18591872),aux.NonTuner(nil),1)
    c:EnableReviveLimit()
    --token
    local e1=Effect.CreateEffect(c)
    e1:SetDescription(aux.Stringid(18591879,0))
    e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
    e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
    e1:SetCode(EVENT_SPSUMMON_SUCCESS)
    e1:SetCondition(c18591879.tkcon)
    e1:SetTarget(c18591879.tktg)
    e1:SetOperation(c18591879.tkop)
    c:RegisterEffect(e1)
    --token
    local e2=Effect.CreateEffect(c)
    e2:SetDescription(aux.Stringid(18591879,1))
    e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
    e2:SetType(EFFECT_TYPE_QUICK_O)
    e2:SetCode(EVENT_FREE_CHAIN)
    e2:SetCountLimit(1)
    e2:SetRange(LOCATION_MZONE)
    e2:SetHintTiming(0,TIMING_BATTLE_START+TIMING_END_PHASE)
    e2:SetCondition(c18591879.tkcon2)
    e2:SetTarget(c18591879.tktg)
    e2:SetOperation(c18591879.tkop2)
    c:RegisterEffect(e2)
    --special summon
    local e3=Effect.CreateEffect(c)
    e3:SetDescription(aux.Stringid(18591879,2))
    e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
    e3:SetCode(EVENT_TO_GRAVE)
    e3:SetCondition(c18591879.spcon)
    e3:SetTarget(c18591879.sptg)
    e3:SetOperation(c18591879.spop)
    c:RegisterEffect(e3)
end
function c18591879.tkcon(e,tp,eg,ep,ev,re,r,rp)
    return Duel.GetTurnPlayer()==tp and e:GetHandler():IsSummonType(SUMMON_TYPE_SYNCHRO)
end
function c18591879.tktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
    if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
    and Duel.IsPlayerCanSpecialSummonMonster(tp,18591867,0,0x2b,1500,1000,4,RACE_WARRIOR,ATTRIBUTE_WIND) end
    Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
    Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c18591879.tkop(e,tp,eg,ep,ev,re,r,rp)
    if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
    if Duel.IsPlayerCanSpecialSummonMonster(tp,18591867,0,0x2b,1500,1000,4,RACE_WARRIOR,ATTRIBUTE_WIND) then
        local token=Duel.CreateToken(tp,18591867)
        Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP_ATTACK)
    end
end
function c18591879.tkcon2(e,tp,eg,ep,ev,re,r,rp)
    return Duel.GetTurnPlayer()~=tp and not Duel.IsExistingMatchingCard(Card.IsType,tp,LOCATION_MZONE,0,1,nil,TYPE_TOKEN)
end
function c18591879.tkop2(e,tp,eg,ep,ev,re,r,rp)
    if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
    if Duel.IsPlayerCanSpecialSummonMonster(tp,18591867,0,0x2b,1500,1000,4,RACE_WARRIOR,ATTRIBUTE_WIND) then
        local token=Duel.CreateToken(tp,18591867)
        Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP_ATTACK)
    end
end
function c18591879.spcon(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    return c:IsReason(REASON_DESTROY) and rp==1-tp and c:IsReason(REASON_EFFECT)
        and c:IsPreviousLocation(LOCATION_MZONE) and c:GetPreviousControler()==tp
end
function c18591879.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
        and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false)
        and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_MZONE,0,1,nil,18591867) end
    Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c18591879.spop(e,tp,eg,ep,ev,re,r,rp)
    if e:GetHandler():IsRelateToEffect(e) then
        Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP_ATTACK)
    end
end

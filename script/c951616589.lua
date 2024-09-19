--☆Star-Star☆ Shooting Stars
local s,id = GetID()
Duel.LoadScript('custom_const.lua')

function s.initial_effect(c)
    local e1 = Effect.CreateEffect(c)
    e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
    -- e1:SetValue(s.zones)
    e1:SetCode(EVENT_FREE_CHAIN)
    e1:SetTarget(s.target)
    e1:SetOperation(s.operation)
    c:RegisterEffect(e1)
end

-- function s.zones(e,tp,eg,ep,ev,re,r,rp)
-- 	local zone=0xff
-- 	if Duel.IsDuelType(DUEL_SEPARATE_PZONE) then return zone end
-- 	local p0=Duel.CheckLocation(tp,LOCATION_PZONE,0)
-- 	local p1=Duel.CheckLocation(tp,LOCATION_PZONE,1)
-- 	if p0==p1 then return zone end
-- 	if p0 then zone=zone-0x1 end
-- 	if p1 then zone=zone-0x10 end
-- 	return zone
-- end

function s.filter(c)
    return c:IsSetCard(SET_STARSTAR) and c:IsType(TYPE_PENDULUM) and c:IsType(TYPE_MONSTER) and not c:IsForbidden()
end

function s.target(e, tp, eg, ep, ev, re, r, rp, chk, chkc)
    if chkc then
        return false
    end

    if chk == 0
    then
        local available_zone, _ = Duel.GetLocationCount(tp, LOCATION_MZONE)
        Debug.Message(available_zone)
        return Duel.IsExistingTarget(s.filter, tp, LOCATION_MZONE, 0, 1, nil) and Duel.IsExistingTarget(s.filter, tp, LOCATION_PZONE, 0, 1, nil) and available_zone > 0
    end

    Duel.Hint(HINT_SELECTMSG, tp, HINTMSG_SPSUMMON)
    local sumcard = Duel.SelectTarget(tp, s.filter, tp, LOCATION_PZONE, 0, 1, 1, nil)
    Duel.Hint(HINT_SELECTMSG, tp, HINTMSG_TARGET)
    local pencard = Duel.SelectTarget(tp, s.filter, tp, LOCATION_MZONE, 0, 1, 1, nil)
    local targets = sumcard:Merge(pencard)
    Duel.SetTargetCard(targets)
    Duel.SetOperationInfo(0, CATEGORY_SPECIAL_SUMMON, sumcard, 10, tp, tp)
end

function s.operation(e, tp, eg, ep, ev, re, r, rp)
    if Duel.GetMZoneCount(tp) <= 0 then return end
    local targets = Duel.GetTargetCards(e)
    local sumcard = targets:Filter(Card.IsLocation, nil, LOCATION_PZONE)
    local pencard = targets:Filter(Card.IsLocation, nil, LOCATION_MZONE)
    if #sumcard >= 1 then
        Duel.SpecialSummon(sumcard, 0, tp, tp, false, false, POS_FACEUP_ATTACK)
    end
    Duel.BreakEffect()
    if #pencard >= 1 then
        Duel.MoveToField(pencard, tp, tp, LOCATION_PZONE, POS_FACEUP, true)
    end
end

--☆Star-Star☆ Shooting Stars
local s,id = GetID()
Duel.LoadScript('custom_const.lua')

function s.initial_effect(c)
    local e1 = Effect.CreateEffect(c)
    e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
    e1:SetCode(EVENT_FREE_CHAIN)
    e1:SetTarget(s.target)
    e1:SetOperation(s.operation)
    c:RegisterEffect(e1)
end

function s.filter(c)
    return c:IsSetCard(SET_STARSTAR) and c:IsType(TYPE_PENDULUM) and c:IsType(TYPE_MONSTER)
end

function s.spfilter(c, e, tp)
    return c:IsSetCard(SET_STARSTAR) and c:IsType(TYPE_PENDULUM) and c:IsCanBeSpecialSummoned(e, 0, tp, false, false, POS_FACEUP_ATTACK, tp)
end

function s.target(e, tp, eg, ep, ev, re, r, rp, chk, chkc)
    if chkc then
        return false
    end

    if chk == 0
    then
        local available_zone, _ = Duel.GetLocationCount(tp, LOCATION_MZONE)
        return Duel.IsExistingTarget(s.filter, tp, LOCATION_MZONE, 0, 1, nil) and Duel.IsExistingTarget(s.spfilter, tp, LOCATION_PZONE, 0, 1, nil, e, tp) and available_zone > 0
    end

    Duel.Hint(HINT_SELECTMSG, tp, HINTMSG_SPSUMMON)
    local sumcard = Duel.SelectTarget(tp, s.spfilter, tp, LOCATION_PZONE, 0, 1, 1, nil, e, tp)
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
        local pc = pencard:GetFirst()
        Duel.MoveToField(pc, tp, tp, LOCATION_PZONE, POS_FACEUP, true)
    end
end

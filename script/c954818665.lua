--☆Star-Star☆ StarStage

local s, id = GetID()
Duel.LoadScript("custom_const.lua")

function s.initial_effect(c)
    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_FREE_CHAIN)
    e1:SetCondition(s.actcon)
    c:RegisterEffect(e1)

    local e2 = Effect.CreateEffect(c)
    e2:SetDescription(aux.Stringid(id, 0)) --Recover LP
    e2:SetCategory(CATEGORY_RECOVER)
    e2:SetType(EFFECT_TYPE_FIELD + EFFECT_TYPE_TRIGGER_O)
    e2:SetCode(EVENT_PHASE + PHASE_END)
    e2:SetRange(LOCATION_FZONE)
    e2:SetCountLimit(1)
    e2:SetTarget(s.rectg)
    e2:SetOperation(s.recop)
    c:RegisterEffect(e2)

    local e3 = Effect.CreateEffect(c)
    e3:SetDescription(aux.Stringid(id, 1)) --Add to Extra Deck
    e3:SetCategory(CATEGORY_TOEXTRA)
    e3:SetType(EFFECT_TYPE_IGNITION)
    e3:SetRange(LOCATION_FZONE)
    e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
    e3:SetCountLimit(1)
    e3:SetTarget(s.extratg)
    e3:SetOperation(s.extraop)
    c:RegisterEffect(e3)
end

--Activate only if you control a "☆Star-Star☆" Pendulum Monster in your Pendulum Zone.
function s.actconfil(c)
    return c:IsSetCard(SET_STARSTAR)
end

function s.actcon(e, tp, eg, ep, ev, re, r, rp)
    return Duel.IsExistingMatchingCard(s.actconfil, tp, LOCATION_PZONE, 0, 1, nil)
end

--Recover LP
function s.rectg(e, tp, eg, ep, ev, re, r, rp, chk, chkc)
    if chk == 0
    then
        return Duel.IsExistingMatchingCard(Card.IsType, tp, 0, LOCATION_MZONE, 1, nil, TYPE_MONSTER)
    end
    local recover_value = Duel.GetFieldGroupCount(tp, 0, LOCATION_MZONE) * 200
    Duel.SetTargetParam(recover_value)
    Duel.SetTargetPlayer(tp)
    Duel.SetOperationInfo(0, CATEGORY_RECOVER, nil, 0, tp, recover_value)
end

function s.recop(e, tp, eg, ep, ev, re, r, rp)
    local val = Duel.GetFieldGroupCount(tp, 0, LOCATION_MZONE) * 200
    Duel.Recover(tp, val, REASON_EFFECT)
end

--Add "☆Star-Star☆" monsters from GY or banishment to Extra Deck
function s.extrafil(c)
    return c:IsSetCard(SET_STARSTAR) and c:IsType(TYPE_PENDULUM) and not c:IsForbidden()
end

function s.extratg(e, tp, eg, ep, ev, re, r, rp, chk, chkc)
    if chkc then
        return chkc:IsSetCard(SET_STARSTAR) and chkc:IsType(TYPE_PENDULUM) and not chkc:IsForbidden()
    end

    if chk == 0 then
        return Duel.IsExistingMatchingCard(aux.NecroValleyFilter(s.extrafil), tp, LOCATION_GRAVE + LOCATION_REMOVED, 0, 1, nil)
    end

    Duel.Hint(HINT_SELECTMSG, tp, HINTMSG_TARGET)
    local tg = Duel.SelectTarget(tp, aux.NecroValleyFilter(s.extrafil), tp, LOCATION_GRAVE + LOCATION_REMOVED, 0, 1, 1, nil)
    Duel.SetTargetCard(tg)
    Duel.SetOperationInfo(0, CATEGORY_TOEXTRA, tg, 0, tp, LOCATION_GRAVE + LOCATION_REMOVED)
end

function s.extraop(e, tp, eg, ep, ev, re, r, rp)
    local tg = Duel.GetTargetCards(e)
    if #tg ~= 0 then
        Duel.SendtoExtraP(tg, tp, REASON_EFFECT)
    end
end

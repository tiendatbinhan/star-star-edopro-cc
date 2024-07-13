--☆Star-Star☆ StarShip
local s,id = GetID()
Duel.LoadScript("custom_const.lua")

function s.initial_effect(c)
    local e1 = Effect.CreateEffect(c)
    e1:SetDescription(aux.Stringid(id, 0))
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_FREE_CHAIN)
    c:RegisterEffect(e1)

    local e2 = Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_FIELD)
    e2:SetCode(EFFECT_UPDATE_ATTACK)
    e2:SetRange(LOCATION_FZONE)
    e2:SetTargetRange(LOCATION_MZONE, 0)
    e2:SetValue(s.atkval)
    c:RegisterEffect(e2)

    local e2_def = Effect.Clone(e2)
    e2_def:SetCode(EFFECT_UPDATE_DEFENSE)
    c:RegisterEffect(e2_def)

    local e3 = Effect.CreateEffect(c)
    e3:SetDescription(aux.Stringid(id, 1))
    e3:SetType(EFFECT_TYPE_IGNITION)
    e3:SetCategory(CATEGORY_DRAW)
    e3:SetRange(LOCATION_FZONE)
    e3:SetCountLimit(1, {id, 0})
    e3:SetCost(s.drawcost)
    e3:SetTarget(s.drawtg)
    e3:SetOperation(s.drawop)
    c:RegisterEffect(e3)
end

--ATK up

function s.atkval(e, c)
    if c:IsSetCard(SET_STARSTAR) then return 400 else return 0 end
end

--Shuffle to draw
function s.drawfil(c)
    return c:IsSetCard(SET_STARSTAR) and c:IsAbleToDeckAsCost()
end

function s.drawcost(e, tp, eg, ep, ev, re, r, rp, chk)
    if chk == 0 then
        return Duel.IsExistingMatchingCard(s.drawfil, tp, LOCATION_ONFIELD, 0, 1, nil)
    end
    Duel.Hint(HINT_SELECTMSG, tp, HINTMSG_TODECK)
    local tc = Duel.SelectMatchingCard(tp, s.drawfil, tp, LOCATION_ONFIELD, 0, 1, 1, nil)
    Duel.SendtoDeck(tc, tp, SEQ_DECKSHUFFLE, REASON_COST)
end

function s.drawtg(e, tp, eg, ep, ev, re, r, rp, chk, chkc)
    if chk == 0 then
        return Duel.IsPlayerCanDraw(tp, 1)
    end
    Duel.SetOperationInfo(0, CATEGORY_DRAW, nil, 1, tp, 0)
end

function s.drawop(e, tp, eg, ep, ev, re, r, rp)
    if Duel.IsPlayerCanDraw(tp, 1) then
        Duel.Draw(tp, 1, REASON_EFFECT)
    end
end

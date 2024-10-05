--☆Star-Star☆ A.IDOL
local s, id = GetID()
Duel.LoadScript("custom_constant.lua")

function s.initial_effect(c)
    local e1 = Effect.CreateEffect(c)
    e1:SetDescription(aux.Stringid(id, 0))
    e1:SetCategory(CATEGORY_SEARCH + CATEGORY_TOGRAVE)
    e1:SetType(EFFECT_TYPE_IGNITION)
    e1:SetRange(LOCATION_MZONE)
    e1:SetCountLimit(1, id)
    e1:SetCost(s.cost)
    e1:SetTarget(s.target)
    e1:SetOperation(s.operation)
    c:RegisterEffect(e1)
end

function s.cost(e, tp, eg, ep, ev, re, r, rp, chk)
    if chk == 0 then return Duel.CheckLPCost(tp, 650) end
    Duel.PayLPCost(tp, 650)
end

function s.target(e, tp, eg, ep, ev, re, r, rp, chk)
    if chk == 0 then
        return Duel.IsPlayerCanDiscardDeck(tp, 3)
    end
    local att = Duel.AnnounceAttribute(tp, 1, ATTRIBUTE_ALL)
    e:SetLabel(att)
    Duel.SetOperationInfo(0, CATEGORY_SEARCH, nil, 1, tp, LOCATION_DECK)
    Duel.SetOperationInfo(0, CATEGORY_TOGRAVE, nil, 2, tp, LOCATION_DECK)
end

function s.filter(c, att)
    return c:IsSetCard(SET_STARSTAR) and c:IsAttribute(att)
end

function s.operation(e, tp, eg, ep, ev, re, r, rp)
    local att = e:GetLabel()
    Duel.ConfirmDecktop(tp, 3)
    local g = Duel.GetDecktopGroup(tp, 3)
    local cg = g:Filter(s.filter, nil, att)
    if #cg > 0 then
        local tc = cg:Select(tp, 1, 1, nil)
        Duel.SendtoHand(tc, tp, REASON_EFFECT)
        Duel.ConfirmCards(1-tp, tc)
        local sg = g:Sub(tc)
        Duel.SendtoGrave(sg, REASON_EFFECT, tp)
    end
    Duel.ShuffleDeck(tp)
end

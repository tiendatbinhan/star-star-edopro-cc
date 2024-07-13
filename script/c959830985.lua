--☆Star-Star☆ Cinder
local s, id = GetID()
Duel.LoadScript("custom_const.lua")
Duel.LoadScript("helper_function.lua")

function s.initial_effect(c)
    local e1 = Effect.CreateEffect(c)
    e1:SetCategory(CATEGORY_FLIP + CATEGORY_SEARCH)
    e1:SetDescription(aux.Stringid(id, 0))
    e1:SetType(EFFECT_TYPE_SINGLE + EFFECT_TYPE_TRIGGER_F)
    e1:SetRange(LOCATION_MZONE)
    e1:SetCode(EVENT_FLIP)
    e1:SetTarget(StarStar.CreateFlipEffectTarget(ATTRIBUTE_FIRE))
    e1:SetOperation(StarStar.CreateFlipEffectOperation(ATTRIBUTE_FIRE))
    c:RegisterEffect(e1)

    local e2 = Effect.CreateEffect(c)
    e2:SetCategory(CATEGORY_POSITION)
    e2:SetDescription(aux.Stringid(id, 1))
    e2:SetType(EFFECT_TYPE_IGNITION)
    e2:SetRange(LOCATION_MZONE)
    e2:SetCountLimit(1)
    e2:SetTarget(s.settg)
    e2:SetOperation(s.setop)
    c:RegisterEffect(e2)
end

--Search effect

function s.addfilter(c)
    return c:IsAbleToHand() and c:IsSetCard(SET_STARSTAR) and c:IsType(TYPE_PENDULUM) and c:IsType(TYPE_MONSTER) and c:IsAttribute(ATTRIBUTE_FIRE)
end

function s.addtg(e, tp, eg, ep, ev, re, r, rp, chk, chkc)
    if chk == 0 then
        return Duel.IsExistingMatchingCard(aux.NecroValleyFilter(s.addfilter), tp, LOCATION_DECK + LOCATION_GRAVE, 0, 1, nil)
    end
    Duel.SetOperationInfo(0, CATEGORY_FLIP + CATEGORY_SEARCH, nil, 1, tp, LOCATION_DECK + LOCATION_GRAVE)
end

function s.addop(e, tp, eg, ep, ev, re, r, rp)
    if not Duel.IsExistingMatchingCard(aux.NecroValleyFilter(s.addfilter), tp, LOCATION_DECK + LOCATION_GRAVE, 0, 1, nil) then return end
    Duel.Hint(HINT_SELECTMSG, tp, HINTMSG_ATOHAND)
    local tc = Duel.SelectMatchingCard(tp, aux.NecroValleyFilter(s.addfilter), tp, LOCATION_DECK + LOCATION_GRAVE, 0, 1, 1, nil)
    Duel.SendtoHand(tc, tp, REASON_EFFECT)
    Duel.ConfirmCards(1-tp, tc)
    Duel.ShuffleDeck(tp)
end

--Self-set effect

function s.settg(e, tp, eg, ep, ev, re, r, rp, chk)
    local c = e:GetHandler()
    if chk == 0 then
        return c:IsCanTurnSet()
    end
    Duel.SetOperationInfo(0, CATEGORY_POSITION, c, 0, tp, 0)
end

function s.setop(e, tp, eg, ep, ev, re, r, rp)
    local c = e:GetHandler()
    if c:IsLocation(LOCATION_MZONE) and c:IsCanTurnSet() then
        Duel.ChangePosition(c, POS_FACEDOWN_DEFENSE)
    end
end

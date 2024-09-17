--☆Star-Star☆ Raito
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
    e1:SetTarget(StarStar.CreateFlipEffectTarget(ATTRIBUTE_LIGHT))
    e1:SetOperation(StarStar.CreateFlipEffectOperation(ATTRIBUTE_LIGHT))
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

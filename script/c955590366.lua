--☆Star-Star☆ StarPet Dragon

local s, id = GetID()
Duel.LoadScript("custom_const.lua")
Duel.LoadScript("helper_function.lua")

function s.initial_effect(c)
    Pendulum.AddProcedure(c)
    aux.AddUnionProcedure(c, aux.FilterBoolFunction(Card.IsSetCard, SET_STARSTAR), false)

    local e1 = Effect.CreateEffect(c)
    e1:SetDescription(aux.Stringid(id, 0))
    e1:SetCategory(CATEGORY_TOHAND + CATEGORY_DESTROY)
    e1:SetType(EFFECT_TYPE_IGNITION)
    e1:SetRange(LOCATION_PZONE)
    e1:SetCountLimit(1, {id, 0})
    e1:SetTarget(StarStar.StarPetSearchTarget(ATTRIBUTE_EARTH))
    e1:SetOperation(StarStar.StarPetSearchOperation(ATTRIBUTE_EARTH))
    c:RegisterEffect(e1)

    local e2 = Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_EQUIP)
    e2:SetCode(EFFECT_UPDATE_ATTACK)
    e2:SetValue(s.atkval)
    c:RegisterEffect(e2)

    local e3 = Effect.CreateEffect(c)
    e3:SetType(EFFECT_TYPE_EQUIP)
    e3:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
    e3:SetCountLimit(1)
    e3:SetValue(s.indesval)
    c:RegisterEffect(e3)
end

--Attack up
function s.atkval(e, c)
    local level = c:GetLevel() or c:GetRank()
    return 250 * level
end

--Immune once to battle or card effect
function s.indesval(e, re, r, rp)
    return (r & REASON_BATTLE) | (r & REASON_EFFECT) ~= 0
end

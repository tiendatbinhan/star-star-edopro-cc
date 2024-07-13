--☆Star-Star☆ StarPet Imp
local s,id = GetID()
Duel.LoadScript("custom_const.lua")
Duel.LoadScript("helper_function.lua")

function s.initial_effect(c)
    Pendulum.AddProcedure(c)
    aux.AddUnionProcedure(c, aux.FilterBoolFunction(Card.IsSetCard, SET_STARSTAR), true)

    local e1 = Effect.CreateEffect(c)
    e1:SetDescription(aux.Stringid(id, 0))
    e1:SetCategory(CATEGORY_TOHAND + CATEGORY_DESTROY)
    e1:SetType(EFFECT_TYPE_IGNITION)
    e1:SetRange(LOCATION_PZONE)
    e1:SetCountLimit(1, {id, 0})
    e1:SetTarget(StarStar.StarPetSearchTarget(ATTRIBUTE_FIRE))
    e1:SetOperation(StarStar.StarPetSearchOperation(ATTRIBUTE_FIRE))
    c:RegisterEffect(e1)

    local e2 = Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_EQUIP)
    e2:SetCode(EFFECT_UPDATE_ATTACK)
    e2:SetValue(s.atkval)
    c:RegisterEffect(e2)

    local e3 = Effect.CreateEffect(c)
    e3:SetType(EFFECT_TYPE_EQUIP)
    e3:SetCode(EFFECT_IMMUNE_EFFECT)
    e3:SetValue(s.immuneval)
    c:RegisterEffect(e3)
end

--Attack up
function s.atkval(e, c)
    local level = c:GetLevel() or c:GetRank()
    return 250 * level
end

--Immune to opponent's monster effects
function s.immuneval(e, re, c)
    local rc = re:GetHandler()
    local tp = c:GetControler()
    return rc:IsControler(1-tp) and rc:IsType(TYPE_MONSTER)
end

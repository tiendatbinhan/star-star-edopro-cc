--☆Star-Star☆ StarPet SpaceCherub

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
    e1:SetTarget(StarStar.StarPetSearchTarget(ATTRIBUTE_LIGHT))
    e1:SetOperation(StarStar.StarPetSearchOperation(ATTRIBUTE_LIGHT))
    c:RegisterEffect(e1)

    local e2 = Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_EQUIP)
    e2:SetCode(EFFECT_UPDATE_ATTACK)
    e2:SetValue(s.atkval)
    c:RegisterEffect(e2)

    local e3 = Effect.CreateEffect(c)
    e3:SetType(EFFECT_TYPE_EQUIP)
    e3:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
    e3:SetCountLimit(1)
    e3:SetValue(s.untargetval)
    c:RegisterEffect(e3)

    local e4 = Effect.CreateEffect(c)
    e4:SetDescription(aux.Stringid(id, 1))
    e4:SetCategory(CATEGORY_LVCHANGE)
    e4:SetType(EFFECT_TYPE_IGNITION)
    e4:SetRange(LOCATION_SZONE)
    e4:SetCountLimit(1)
    e4:SetTarget(s.lvtg)
    e4:SetOperation(s.lvop)
    c:RegisterEffect(e4)
end

--Attack up
function s.atkval(e, c)
    local level = c:GetLevel() or c:GetRank()
    return 200 * level
end

--Cannot be target by opponent's Spell/Trap
function s.untargetval(e, re, rp)
    local c = e:GetHandler()
    local tp = c:GetControler()
    local rc = re:GetHandler()
    return (rc:IsType(TYPE_SPELL) or rc:IsType(TYPE_TRAP)) and rc:IsControler(1-tp)
end

--Increase Level/Rank by 1
function s.lvtg(e, tp, eg, ep, ev, re, r, rp, chk, chkc)
    local c = e:GetHandler()
    local ec = c:GetEquipTarget()
    if chk == 0
    then
        return e:IsActiveType(TYPE_UNION) and ec and (ec:HasLevel() or ec:HasRank())
    end
    Duel.SetOperationInfo(0, CATEGORY_LVCHANGE, ec, 0, tp, 1)
end

function s.lvop(e, tp, eg, ep, ev, re, r, rp)
    local c = e:GetHandler()
    local ec = c:GetEquipTarget()
    if not (ec and (ec:HasLevel() or ec:HasRank())) then return end
    local ee = Effect.CreateEffect(c)
    ee:SetType(EFFECT_TYPE_SINGLE)
    if ec:HasLevel() then
        ee:SetCode(EFFECT_UPDATE_LEVEL)
    else
        ee:SetCode(EFFECT_UPDATE_RANK)
    end
    ee:SetRange(LOCATION_MZONE)
    ee:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
    ee:SetValue(1)
    ee:SetReset(RESET_EVENT+RESETS_STANDARD)
    ec:RegisterEffect(ee)
end

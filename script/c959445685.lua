--☆Star-Star☆ StarPet Imp
local s,id = GetID()
Duel.LoadScript("custom_const.lua")

function s.initial_effect(c)
    Pendulum.AddProcedure(c)
    aux.AddUnionProcedure(c, aux.FilterBoolFunction(Card.IsSetCard, SET_STARSTAR), true)

    local e1 = Effect.CreateEffect(c)
    e1:SetDescription(aux.Stringid(id, 0))
    e1:SetCategory(CATEGORY_TOHAND + CATEGORY_DESTROY)
    e1:SetType(EFFECT_TYPE_IGNITION)
    e1:SetRange(LOCATION_PZONE)
    e1:SetCountLimit(1, {id, 0})
    e1:SetTarget(s.addtg)
    e1:SetOperation(s.addop)
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

--Add from GY effect
function s.addfilter(c)
    return c:IsAbleToHand() and c:IsSetCard(SET_STARSTAR) and c:IsAttribute(ATTRIBUTE_FIRE)
end

function s.addtg(e, tp, eg, ep, ev, re, r, rp, chk)
    local c = e:GetHandler()
    if chk == 0
    then
        return Duel.IsExistingMatchingCard(s.addfilter, tp, LOCATION_GRAVE, 0, 1, nil) and c:IsDestructable(e) and not Duel.IsPlayerAffectedByEffect(tp, CARD_NECROVALLEY)
    end
    Duel.SetOperationInfo(0, CATEGORY_TOHAND, nil, 1, tp, LOCATION_GRAVE)
    Duel.SetOperationInfo(0, CATEGORY_DESTROY, c, 0, tp, 0)
end

function s.addop(e, tp, eg, ep, ev, re, r, rp)
    local c = e:GetHandler()
    if Duel.Destroy(c, REASON_EFFECT) > 0
        and Duel.IsExistingMatchingCard(s.addfilter, tp, LOCATION_GRAVE, 0, 1, nil)
        and not Duel.IsPlayerAffectedByEffect(tp, CARD_NECROVALLEY)
    then
        Duel.Hint(HINT_SELECTMSG, tp, HINTMSG_ATOHAND)
        local tc = Duel.SelectMatchingCard(tp, s.addfilter, tp, LOCATION_GRAVE, 0, 1, 1, nil)
        Duel.SendtoHand(tc, tp, REASON_EFFECT)
        Duel.ConfirmCards(1-tp, tc)
    end
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

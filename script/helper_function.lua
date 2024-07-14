if not StarStar then
    StarStar = {}
end

--For flip effect of non-Pendulum Monster
function StarStar.FlipEffectFilter(c, attribute)
    return c:IsAbleToHand() and c:IsSetCard(SET_STARSTAR) and c:IsType(TYPE_PENDULUM) and c:IsType(TYPE_MONSTER) and c:IsAttribute(attribute)
end

function StarStar.CreateFlipEffectTarget(attribute)
    return function(e, tp, eg, ep, ev, re, r, rp, chk, chkc)
        if chk == 0 then
            return Duel.IsExistingMatchingCard(aux.NecroValleyFilter(StarStar.FlipEffectFilter), tp, LOCATION_DECK + LOCATION_GRAVE, 0, 1, nil, attribute)
        end
        Duel.SetOperationInfo(0, CATEGORY_FLIP + CATEGORY_SEARCH, nil, 1, tp, LOCATION_DECK + LOCATION_GRAVE)
    end
end

function StarStar.CreateFlipEffectOperation(attribute)
    return function(e, tp, eg, ep, ev, re, r, rp)
        if not Duel.IsExistingMatchingCard(aux.NecroValleyFilter(StarStar.FlipEffectFilter), tp, LOCATION_DECK + LOCATION_GRAVE, 0, 1, nil, attribute) then return end
        Duel.Hint(HINT_SELECTMSG, tp, HINTMSG_ATOHAND)
        local tc = Duel.SelectMatchingCard(tp, aux.NecroValleyFilter(StarStar.FlipEffectFilter), tp, LOCATION_DECK + LOCATION_GRAVE, 0, 1, 1, nil, attribute)
        Duel.SendtoHand(tc, tp, REASON_EFFECT)
        Duel.ConfirmCards(1-tp, tc)
        if tc:GetFirst():IsPreviousLocation(LOCATION_DECK) then
            Duel.ShuffleDeck(tp)
        end
    end
end

--For SP Summon of most non-StarPet Pendulum Monsters
function StarStar.AddNonUnionPendulumProcedure(c)
    local e = Effect.CreateEffect(c)
    e:SetCategory(CATEGORY_SPECIAL_SUMMON + CATEGORY_TODECK)
    e:SetType(EFFECT_TYPE_FIELD + EFFECT_TYPE_QUICK_O)
    e:SetCode(EVENT_FREE_CHAIN)
    e:SetRange(LOCATION_HAND)
    e:SetTarget(StarStar.NonUnionProcTarget)
    e:SetOperation(StarStar.NonUnionProcOperation)
    return e
end

function StarStar.NonUnionReturnFilter(c)
    return c:IsFaceup() and c:IsSetCard(SET_STARSTAR) and c:IsAbleToDeck()
end

function StarStar.NonUnionProcTarget(e, tp, eg, ep, ev, re, r, rp, chk, chkc)
    local c = e:GetHandler()
    if chk == 0
    then
        return c:IsCanBeSpecialSummoned(e, 0, tp, false, false, POS_FACEUP, tp) and Duel.IsExistingMatchingCard(StarStar.NonUnionReturnFilter, tp, LOCATION_MZONE, 0, 1, nil)
    end
    Duel.SetOperationInfo(0, CATEGORY_SPECIAL_SUMMON + CATEGORY_TODECK, c, 1, tp, 0)
end

function StarStar.NonUnionProcOperation(e, tp, eg, ep, ev, re, r, rp, chk)
    local c = e:GetHandler()
    if not (c:IsCanBeSpecialSummoned(e, SUMMON_TYPE_SPECIAL, tp, false, false, POS_FACEUP, tp) and Duel.IsExistingMatchingCard(StarStar.NonUnionReturnFilter, tp, LOCATION_MZONE, 0, 1, nil))
    then
        return
    end
    Duel.Hint(HINT_SELECTMSG, tp, HINTMSG_TODECK)
    local gc = Duel.SelectMatchingCard(tp, StarStar.NonUnionReturnFilter, tp, LOCATION_MZONE, 0, 1, 1, nil)
    if Duel.SendtoDeck(gc, tp, SEQ_DECKSHUFFLE, REASON_EFFECT) > 0 then
        Duel.SpecialSummon(c, SUMMON_TYPE_SPECIAL, tp, tp, false, false, POS_FACEUP)
    end
end

--For StarPet search effect in Pendulum Zone
function StarStar.StarPetSearchFilter(c, att)
    return c:IsAbleToHand() and c:IsSetCard(SET_STARSTAR) and c:IsAttribute(att)
end

function StarStar.StarPetSearchTarget(attribute)
    return function(e, tp, eg, ep, ev, re, r, rp, chk)
        local c = e:GetHandler()
        if chk == 0
        then
            return Duel.IsExistingMatchingCard(StarStar.StarPetSearchFilter, tp, LOCATION_GRAVE, 0, 1, nil, attribute) and c:IsDestructable(e) and not Duel.IsPlayerAffectedByEffect(tp, CARD_NECROVALLEY)
        end
        Duel.SetOperationInfo(0, CATEGORY_TOHAND, nil, 1, tp, LOCATION_GRAVE)
        Duel.SetOperationInfo(0, CATEGORY_DESTROY, c, 0, tp, 0)
    end
end

function StarStar.StarPetSearchOperation(attribute)
    return function(e, tp, eg, ep, ev, re, r, rp)
        local c = e:GetHandler()
        if Duel.Destroy(c, REASON_EFFECT) > 0
            and Duel.IsExistingMatchingCard(StarStar.StarPetSearchFilter, tp, LOCATION_GRAVE, 0, 1, nil, attribute)
            and not Duel.IsPlayerAffectedByEffect(tp, CARD_NECROVALLEY)
        then
            Duel.Hint(HINT_SELECTMSG, tp, HINTMSG_ATOHAND)
            local tc = Duel.SelectMatchingCard(tp, StarStar.StarPetSearchFilter, tp, LOCATION_GRAVE, 0, 1, 1, nil, attribute)
            Duel.SendtoHand(tc, tp, REASON_EFFECT)
            Duel.ConfirmCards(1-tp, tc)
        end
    end
end

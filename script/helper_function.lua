if not StarStar then
    StarStar = {}
end

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
        Duel.ShuffleDeck(tp)
    end
end

--☆Star-Star☆ Starblaze Singer
local s,id = GetID()
Duel.LoadScript("custom_const.lua")

function s.initial_effect(c)
    Pendulum.AddProcedure(c)
    local e1 = Effect.CreateEffect(c)
    e1:SetDescription(aux.Stringid(id, 0))
    e1:SetCategory(CATEGORY_DRAW)
    e1:SetType(EFFECT_TYPE_FIELD + EFFECT_TYPE_TRIGGER_O)
    e1:SetProperty(EFFECT_FLAG_DELAY)
    e1:SetRange(LOCATION_PZONE)
    e1:SetCode(EVENT_SPSUMMON)
    e1:SetCountLimit(1, {id, 0})
    e1:SetCondition(s.pencon)
    e1:SetTarget(s.pentg)
    e1:SetOperation(s.penop)
    c:RegisterEffect(e1)

    local e2 = Effect.CreateEffect(c)
    e2:SetDescription(aux.Stringid(id, 1))
    e2:SetCategory(CATEGORY_SPECIAL_SUMMON + CATEGORY_TODECK)
    e2:SetType(EFFECT_TYPE_FIELD + EFFECT_TYPE_QUICK_O)
    e2:SetCode(EVENT_FREE_CHAIN)
    e2:SetCountLimit(1, {id, 1})
    e2:SetRange(LOCATION_HAND)
    e2:SetTarget(s.sptg)
    e2:SetOperation(s.spop)
    c:RegisterEffect(e2)

    local e3 = Effect.CreateEffect(c)
    e3:SetDescription(aux.Stringid(id, 2))
    e3:SetCategory(CATEGORY_SEARCH)
    e3:SetType(EFFECT_TYPE_SINGLE + EFFECT_TYPE_TRIGGER_O)
    e3:SetCode(EVENT_SPSUMMON_SUCCESS)
    e3:SetRange(LOCATION_MZONE)
    e3:SetProperty(EFFECT_FLAG_DELAY)
    e3:SetCountLimit(1, {id, 2})
    e3:SetCondition(s.addcon)
    e3:SetTarget(s.addtg)
    e3:SetOperation(s.addop)
    c:RegisterEffect(e3)

    local e4 = Effect.CreateEffect(c)
    e4:SetDescription(aux.Stringid(id, 3))
    e4:SetCategory(CATEGORY_ATKCHANGE + CATEGORY_POSITION)
    e4:SetType(EFFECT_TYPE_SINGLE + EFFECT_TYPE_TRIGGER_O)
    e4:SetCode(EVENT_SPSUMMON_SUCCESS)
    e4:SetRange(LOCATION_MZONE)
    e4:SetProperty(EFFECT_FLAG_DELAY + EFFECT_FLAG_CARD_TARGET)
    e4:SetHintTiming(0, TIMINGS_CHECK_MONSTER)
    e4:SetCountLimit(1, {id, 3})
    e4:SetCondition(s.atkcon)
    e4:SetTarget(s.atktg)
    e4:SetOperation(s.atkop)
    c:RegisterEffect(e4)
end

--Pendulum Effect

function s.penfil(c, tp)
    return c:IsFaceup() and c:IsSummonType(SUMMON_TYPE_PENDULUM) and c:IsSummonPlayer(tp)
end

function s.pencon(e, tp, eg, ep, ev, re, r, rp)
    return eg:IsExists(s.penfil, 1, nil, tp)
end

function s.pentg(e, tp, eg, ep, ev, re, r, rp, chk, chkc)
    local c = e:GetHandler()
    if chk == 0
    then
        return c:IsAbleToDeck() and Duel.IsPlayerCanDraw(tp, 1)
    end
    Duel.SetOperationInfo(0, CATEGORY_DRAW, nil, 1, tp, 0)
end

function s.penop(e, tp, eg, ep, ev, re, r, rp)
    local c = e:GetHandler()
    if Duel.SendtoDeck(c, tp, SEQ_DECKTOP, REASON_EFFECT) > 0 and Duel.IsPlayerCanDraw(tp, 1)
    then
        Duel.ShuffleDeck(tp)
        Duel.Draw(tp, 1, REASON_EFFECT)
    end
end

--Special Summon itself
function s.spfilter(c)
    return c:IsFaceup() and c:IsSetCard(SET_STARSTAR) and c:IsAbleToDeck()
end

function s.sptg(e, tp, eg, ep, ev, re, r, rp, chk, chkc)
    local c = e:GetHandler()
    if chk == 0
    then
        return c:IsCanBeSpecialSummoned(e, 0, tp, false, false, POS_FACEUP, tp) and Duel.IsExistingMatchingCard(s.spfilter, tp, LOCATION_MZONE, 0, 1, nil)
    end
    Duel.SetOperationInfo(0, CATEGORY_SPECIAL_SUMMON + CATEGORY_TODECK, c, 1, tp, 0)
end

function s.spop(e, tp, eg, ep, ev, re, r, rp)
    local c = e:GetHandler()
    if not (c:IsCanBeSpecialSummoned(e, SUMMON_TYPE_SPECIAL, tp, false, false, POS_FACEUP, tp) and Duel.IsExistingMatchingCard(s.spfilter, tp, LOCATION_MZONE, 0, 1, nil))
    then
        return
    end
    Duel.Hint(HINT_SELECTMSG, tp, HINTMSG_TODECK)
    local gc = Duel.SelectMatchingCard(tp, s.spfilter, tp, LOCATION_MZONE, 0, 1, 1, nil)
    if Duel.SendtoDeck(gc, tp, SEQ_DECKSHUFFLE, REASON_EFFECT) > 0 then
        Duel.SpecialSummon(c, SUMMON_TYPE_SPECIAL, tp, tp, false, false, POS_FACEUP)
    end
end

--Add Field Spell
function s.addcon(e, tp, eg, ep, ev, re, r, rp)
    local c = e:GetHandler()
    return c:IsSummonType(SUMMON_TYPE_PENDULUM)
end

function s.addfilter(c)
    return c:IsSetCard(SET_STARSTAR) and c:IsType(TYPE_FIELD) and c:IsType(TYPE_SPELL) and c:IsAbleToHand()
end

function s.addtg(e, tp, eg, ep, ev, re, r, rp, chk, chkc)
    if chk == 0 then
        return Duel.IsExistingMatchingCard(s.addfilter, tp, LOCATION_DECK, 0, 1, nil)
    end
    Duel.SetOperationInfo(0, CATEGORY_SEARCH, nil, 1, tp, LOCATION_DECK)
end

function s.addop(e, tp, eg, ep, ev, re, r, rp)
    if not Duel.IsExistingMatchingCard(s.addfilter, tp, LOCATION_DECK, 0, 1, nil) then
        return
    end
    Duel.Hint(HINT_SELECTMSG, tp, HINTMSG_ATOHAND)
    local gc = Duel.SelectMatchingCard(tp, s.addfilter, tp, LOCATION_DECK, 0, 1, 1, nil)
    Duel.SendtoHand(gc, tp, REASON_EFFECT)
    Duel.ConfirmCards(1-tp, gc)
end

--Change ATK

function s.atkcon(e, tp, eg, ep, ev, re, r, rp)
    if not re then return false end
    local c = e:GetHandler()
    return re:GetHandler() == c
end

function s.atkfilter(c,tp)
    return c:IsControler(1-tp) and c:IsType(TYPE_MONSTER) and c:IsCanChangePosition()
end

function s.atkval(c)
    local amount = 0
    if c:IsType(TYPE_LINK) then
        local link_rating = c:GetLink()
        amount = link_rating * 350
    else
        local level = c:GetLevel() or c:GetRank()
        amount = level * 200
    end
    return amount
end

function s.atktg(e, tp, eg, ep, ev, re, r, rp, chk, chkc)
    if chkc then
        return chkc:IsControler(1-tp) and chkc:IsType(TYPE_MONSTER) and chkc:IsCanChangePosition()
    end
    if chk == 0 then
        return Duel.IsExistingTarget(s.atkfilter, tp, 0, LOCATION_MZONE, 1, nil, tp)
    end
    Duel.Hint(HINT_SELECTMSG, tp, HINTMSG_TARGET)
    local tc = Duel.SelectTarget(tp, s.atkfilter, tp, 0, LOCATION_MZONE, 1, 1, nil, tp)
    Duel.SetTargetCard(tc)
    local amount = -s.atkval(tc:GetFirst())
    Duel.SetTargetParam(amount)
    Duel.SetOperationInfo(0, CATEGORY_ATKCHANGE, tc, 0, 1-tp, amount)
    Duel.SetOperationInfo(0, CATEGORY_POSITION, tc, 0, 1-tp, 0)
end

function s.atkop(e, tp, eg, ep, ev, re, r, rp)
    local c = e:GetHandler()
    local tg = Duel.GetTargetCards(e)
    local tc = tg:GetFirst()
    local amount = -s.atkval(tc)
    if tc:IsRelateToEffect(e) and tc:IsLocation(LOCATION_MZONE) and tc:IsCanChangePosition() then
        Duel.ChangePosition(tc, POS_FACEUP_ATTACK, POS_FACEUP_ATTACK, POS_FACEUP_ATTACK, POS_FACEUP_ATTACK, true)
        local e1 = Effect.CreateEffect(c)
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetRange(LOCATION_MZONE)
        e1:SetCode(EFFECT_UPDATE_ATTACK)
        e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
        e1:SetValue(amount)
        e1:SetReset(RESET_EVENT + RESETS_STANDARD)
        tc:RegisterEffect(e1)
    end
end

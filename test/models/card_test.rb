# frozen_string_literal: true

require "test_helper"

class CardTest < ActiveSupport::TestCase
  test "is valid" do
    assert_predicate FactoryBot.build(:card), :valid?
  end

  test "validates that question is present" do
    assert_not_predicate FactoryBot.build(:card, question: ""), :valid?
  end

  test "validates that answer is present" do
    assert_not_predicate FactoryBot.build(:card, answer: nil), :valid?
  end

  test ".find_for_attempt finds a card that has never been attempted" do
    card = FactoryBot.create(:card, last_successful_attempt_at: nil)
    assert_equal card, Card.find_for_attempt
  end

  test ".find_for_attempt finds a card that hasn't been attempted in a while" do
    card = FactoryBot.create(:card, last_successful_attempt_at: 2.hours.ago)
    assert_equal card, Card.find_for_attempt
  end

  test ".find_for_attempt returns nil if all cards have been attempted" do
    FactoryBot.create(:card, last_successful_attempt_at: Time.zone.now)
    assert_nil Card.find_for_attempt
  end

  test "#answer returns the encrypted but comparable answer" do
    card = FactoryBot.build(:card, answer: "hello")
    assert_not_equal "hello", card.answer
    assert card.answer == "hello"
  end

  test "#mark_successful_attempt updates the attempted timestamp" do
    card = FactoryBot.create(:card)
    freeze_time do
      card.mark_successful_attempt
      assert_equal Time.zone.now, card.last_successful_attempt_at
    end
  end
end

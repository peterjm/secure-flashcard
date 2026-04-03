# frozen_string_literal: true

require "application_system_test_case"

class FlashcardFlowTest < ApplicationSystemTestCase
  setup do
    OmniAuth.config.mock_auth[:google] = successful_google_auth_hash
  end

  test "unauthenticated user is redirected to login" do
    visit root_path
    assert_current_path login_path
  end

  test "logging in and seeing a flashcard" do
    card = FactoryBot.create(:card, question: "Capital of France?", answer: "Paris")

    visit root_path
    assert_current_path login_path

    click_on "Log in with Google"
    assert_text "Capital of France?"
  end

  test "answering a flashcard correctly" do
    card = FactoryBot.create(:card, question: "Capital of France?", answer: "Paris")

    log_in_via_system
    assert_text "Capital of France?"

    fill_in "Answer", with: "Paris"
    click_on "Try"

    assert_text "All done"
  end

  test "answering a flashcard incorrectly" do
    card = FactoryBot.create(:card, question: "Capital of France?", answer: "Paris")

    log_in_via_system
    fill_in "Answer", with: "London"
    click_on "Try"

    assert_current_path card_path(card)
    assert_text "Capital of France?"
  end

  test "creating a new card" do
    log_in_via_system

    click_on "New card"
    fill_in "Question", with: "What is 2 + 2?"
    fill_in "Answer", with: "4"
    click_on "Submit"

    assert_text "What is 2 + 2?"
  end

  test "editing a card" do
    card = FactoryBot.create(:card, question: "Old question", answer: "answer")

    log_in_via_system
    click_on "Cards"
    click_on "Old question"
    click_on "Edit this card"

    fill_in "Question", with: "New question"
    click_on "Submit"

    assert_text "New question"
  end

  test "viewing the card list" do
    FactoryBot.create(:card, question: "Card A", answer: "a")
    FactoryBot.create(:card, question: "Card B", answer: "b")

    log_in_via_system
    click_on "Cards"

    assert_text "Card A"
    assert_text "Card B"
  end

  private

  def log_in_via_system
    visit root_path
    click_on "Log in with Google"
  end
end

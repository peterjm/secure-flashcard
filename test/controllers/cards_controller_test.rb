# frozen_string_literal: true

require "test_helper"

class CardsControllerTest < ActionDispatch::IntegrationTest
  setup do
    log_in
  end

  test "#index requires authentication" do
    log_out
    get root_path
    assert_redirected_to login_path
  end

  test "#index lists cards" do
    get cards_path
    assert_response :success
  end

  test "#show renders" do
    card = FactoryBot.create(:card)
    get card_path(card)
    assert_response :success
  end

  test "#show requires valid card id" do
    assert_raise ActiveRecord::RecordNotFound do
      get card_path(1)
    end
  end

  test "#new renders" do
    get new_card_path
    assert_response :success
  end

  test "#edit renders" do
    card = FactoryBot.create(:card)
    get edit_card_path(card)
    assert_response :success
  end

  test "#edit requires valid card id" do
    assert_raise ActiveRecord::RecordNotFound do
      get edit_card_path(1)
    end
  end

  test "#create makes a new card" do
    assert_difference(-> { Card.count }, 1) do
      post cards_path, params: { card: { question: "hello", answer: "jello" } }
    end
    card = Card.last
    assert_equal "hello", card.question
    assert card.answer == "jello"
  end

  test "#create renders when error occurs" do
    assert_no_difference(-> { Card.count }) do
      post cards_path, params: { card: { answer: "jello" } }
    end
    assert_response :bad_request
  end

  test "#update requires valid card id" do
    assert_raise ActiveRecord::RecordNotFound do
      put card_path(1)
    end
  end

  test "#update updates card" do
    card = FactoryBot.create(:card)
    assert_no_difference(-> { Card.count }) do
      put card_path(card), params: { card: { question: "hello", answer: "jello" } }
    end
    card.reload
    assert_equal "hello", card.question
    assert card.answer == "jello"
  end

  test "#update renders when error occurs" do
    card = FactoryBot.create(:card)
    assert_no_difference(-> { Card.count }) do
      put card_path(card), params: { card: { question: "", answer: "jello" } }
    end
    assert_response :bad_request
  end
end

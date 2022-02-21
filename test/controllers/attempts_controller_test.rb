# frozen_string_literal: true

require "test_helper"

class AttemptsControllerTest < ActionDispatch::IntegrationTest
  setup do
    log_in
  end

  test "#create requires authentication" do
    log_out
    post card_attempts_path(1)
    assert_redirected_to login_path
  end

  test "#create requires valid card id" do
    assert_raise ActiveRecord::RecordNotFound do
      post card_attempts_path(1)
    end
  end

  test "#create marks the card as successful when attempt is correct" do
    card = FactoryBot.create(:card, answer: "correct")
    freeze_time do
      post card_attempts_path(card), params: { attempt: "correct" }
      assert_equal Time.zone.now, card.reload.last_successful_attempt_at
    end
    assert_redirected_to root_path
    assert_equal "Right", flash[:notice]
  end

  test "#create redirects back to card path when attempt is wrong" do
    card = FactoryBot.create(:card, answer: "correct")
    post card_attempts_path(card), params: { attempt: "incorrect" }
    assert_redirected_to card_path(card)
    assert_equal "Wrong", flash[:alert]
  end
end

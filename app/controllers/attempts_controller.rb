# frozen_string_literal: true

class AttemptsController < AuthenticatedController
  def create
    card = Card.find(params.require(:card_id))
    if card.answer == params[:attempt]
      card.mark_successful_attempt
      redirect_to root_path, notice: "Right"
    else
      redirect_to card_path(card), alert: "Wrong"
    end
  end
end

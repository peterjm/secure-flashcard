# frozen_string_literal: true

class HomeController < AuthenticatedController

  def show
    card = Card.find_for_attempt
    if card
      @card = card
      render "cards/show"
    else
      render "no_cards_to_attempt"
    end
  end

end

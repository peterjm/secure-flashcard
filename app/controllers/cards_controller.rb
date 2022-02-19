# frozen_string_literal: true

class CardsController < AuthenticatedController
  def index
    @cards = Card.all
  end

  def show
    @card = Card.find(params.require(:id))
  end

  def new
    @card = Card.new
  end

  def create
    card = Card.new(card_params)
    if card.save
      redirect_to card_path(card)
    else
      @card = card
      render :new, status: :bad_request
    end
  end

  def edit
    @card = Card.find(params.require(:id))
  end

  def update
    card = Card.find(params.require(:id))
    if card.update(card_params)
      redirect_to card_path(card)
    else
      @card = card
      render :edit, status: :bad_request
    end
  end

  private

  def card_params
    params.require(:card).permit(:question, :answer)
  end
end

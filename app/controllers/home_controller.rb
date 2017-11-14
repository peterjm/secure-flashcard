class HomeController < AuthenticatedController

  def show
    @card = Card.find_for_attempt
    render 'cards/show'
  end

end

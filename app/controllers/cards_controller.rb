class CardsController < ApplicationController
  before_action :set_deck

  def index
    @cards = @deck.cards
  end

  def show
    @deck = current_user.decks.find(params[:deck_id])
    @card = deck.cards.find(params[:id])
  end

  def new
    @card = @deck.cards.new
  end

  def create
    @card = @deck.cards.new(card_params)

    if @card.save
      redirect_to deck_path(@deck), notice: 'Card was successfully created.'
    else
      render partial: 'cards/new'
    end
  end

  def edit
    @deck = current_user.decks.find(params[:deck_id])
    @card = @deck.cards.find(params[:id])
  end

  def update
    @card = @deck.cards.find(params[:id])

    if @card.update(card_params)
      redirect_to deck_path(@deck), notice: 'Card was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @card = @deck.cards.find(params[:id])
    @card.destroy

    redirect_to deck_cards_path(@deck), notice: 'Card was successfully deleted.'
  end

  private

  def set_deck
    @deck = current_user.decks.find(params[:deck_id])
  end

  def card_params
    params.require(:card).permit(:question, :answer, tags: [])
  end
end

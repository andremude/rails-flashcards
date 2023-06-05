class DecksController < ApplicationController

  def index
    @decks = current_user&.decks
  end

  def show
    @deck = current_user.decks.find(params[:id])
  end

  def new
    @deck = current_user.decks.new
  end

  def create
    @deck = Deck.new(deck_params)
    @deck.user = current_user

    if @deck.save
      redirect_to decks_path
    else
      render :new
    end
  end

  def edit
    @deck = current_user.decks.find(params[:id])
  end

  def update
    @deck = current_user.decks.find(params[:id])
    if @deck.update(deck_params)
      redirect_to decks_path, notice: "Deck was updated."
    else
      redirect_to decks_path, notice: "There was an error."
    end
  end

  def destroy
    if current_user == @deck.user
      @deck.destroy
      redirect_to decks_path, notice: "Deck was deleted."
    else
      redirect_to decks_path, notice: "Deck can't be deleted."
    end
  end

  private

  def deck_params
    params.require(:deck).permit(
      :name,
      :id,
      :user_id
    )
  end
end

class Public::GamesController < ApplicationController
  before_action :authenticate_customer!, only: [:create]

  def new
    @game = Game.new
    @customer = current_customer
  end

  def create
    @game = Game.find_or_create_by(game_name: game_params[:game_name])
    @game.customer = current_customer
    @game.save
    redirect_to new_game_post_path(@game)
  end

  private

  def game_params
    params.require(:game).permit(:game_name)
  end

end

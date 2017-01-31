class HomeController < ApplicationController
  def index
    @user_ratings = User.order(ratings: :desc).all
  end

  def history
    @game_history = GameHistory.build(current_user)
  end

  def log
  end
end

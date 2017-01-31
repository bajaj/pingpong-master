class HomeController < ApplicationController
  def index
    puts "wfwjfef"
    @user_ratings = User.all
    puts "geege"
  end

  def history
    @game_history = GameHistory.build(current_user)
  end

  def log
  end
end

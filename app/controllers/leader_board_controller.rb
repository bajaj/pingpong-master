class LeaderBoardController < ApplicationController

  def list
    @user_ratings = User.all
  end


end

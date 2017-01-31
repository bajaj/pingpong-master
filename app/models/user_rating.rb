require 'elo'

class UserRating < ActiveRecord::Base
  belongs_to :user


  #The rating you provided, or the default rating from configuration
  def default_rating
     @rating ||= Elo.config.default_rating
   end

  # The number of games played is needed for calculating the K-factor.
  def games_played
    @games_played ||= user.get_my_games.size
  end

  # Is the player considered a pro, because his/her rating crossed
  # the threshold configured? This is needed for calculating the K-factor.
  def pro_rating?
    self.rating >= Elo.config.pro_rating_boundry
  end

  # Is the player just starting? Provide the boundry for
  # the amount of games played in the configuration.
  # This is needed for calculating the K-factor.
  def starter?
    games_played < Elo.config.starter_boundry
  end

  # FIDE regulations specify that once you reach a pro status
  # (see +pro_rating?+), you are considered a pro for life.
  #
  # You might need to specify it manually, when depending on
  # external persistence of players.
  #
  #		Elo::Player.new(:pro => true)
  def pro?
    !!@pro
  end


  # Calculates the K-factor for the player.
  # Elo allows you specify custom Rules (see Elo::Configuration).
  #
  # You can set it manually, if you wish:
  #
  #		Elo::Player.new(:k_factor => 10)
  #
  #	This stops this player from using the K-factor rules.
  def k_factor
    return @k_factor if @k_factor
    Elo.config.applied_k_factors.each do |rule|
      return rule[:factor] if instance_eval(&rule[:rule])
    end
    Elo.config.default_k_factor
  end

  # A Game tells the players informed to update their
  # scores, after it knows the result (so it can calculate the rating).
  #
  # This method is private, because it is called automatically.
  # Therefore it is not part of the public API of Elo.

  # private
  #
  # def played(game)
  #   self.ratings = game.ratings[self].new_rating
  #   @pro    = true if pro_rating?
  #   save
  # end


end

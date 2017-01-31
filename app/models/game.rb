require 'elo'

class Game < ActiveRecord::Base
  belongs_to :player_1, :class_name => 'User', :foreign_key => 'player_1'
  belongs_to :player_2, :class_name => 'User', :foreign_key => 'player_2'


  # Every time a result is set, it tells the Elo::Player
  # objects to update their scores.
  def process_result(new_result)
    @result = new_result
    calculate
  end

  def calculate
    if @result
      player_1.send(:played, self)
      player_2.send(:played, self)
      #save
    end
    self
  end

  # Player +:one+ has won!
  # This is a shortcut method for setting the score to 1
  def win
    puts "cool win"
    process_result 1.0
  end

  # Player +:one+ has lost!
  # This is a shortcut method for setting the score to 0
  def lose
    process_result 0.0
  end

  # It was a draw.
  # This is a shortcut method for setting the score to 0.5
  def draw
    process_result 0.5
  end


  # Set the winner. Provide it with a Elo::Player.
  def winner=(player)
    process_result(player == player_1 ? 1.0 : 0.0)
  end

  # Set the loser. Provide it with a Elo::Player.
  def loser=(player)
    process_result(player == player_1 ? 0.0 : 1.0)
  end

  # Access the Elo::Rating objects for both players.
  def ratings
    @ratings ||= { player_1 => rating_one, player_2 => rating_two }
  end


  private

  # Create an Elo::Rating object for player one
  def rating_one
    Elo::Rating.new(:result        => @result,
                    :old_rating    => player_1.ratings,
                    :other_rating  => player_2.ratings,
                    :k_factor      => player_1.k_factor)
  end

  # Create an Elo::Rating object for player two
  def rating_two
    Elo::Rating.new(:result        => (1.0 - @result),
                    :old_rating    => player_2.ratings,
                    :other_rating  => player_1.ratings,
                    :k_factor      => player_2.k_factor)
  end


end

class GamePresenter
  def initialize(game, player)
    @game = game
    @player = player
  end

  def opponent
    @opponent ||= get_opponent
  end

  def score
    [player_score, opponent_score].join("-")
  end

  def result
    return "W" if player_score > opponent_score
    "L"
  end

  def date
    game.created_at.strftime("%b %d, %Y")
  end

  private

  attr_reader :player, :game, :player_score, :opponent_score

  def get_opponent
    if game.player_1 == player
       game.player_2
    else game.player_1
    end

  end

  def player_score
    @player_score ||= game.player_1 == player ? game.player_1_score : game.player_2_score
  end

  def opponent_score
    @opponent_score ||= game.player_1 == player ? game.player_2_score : game.player_1_score
  end
end
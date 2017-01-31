class GameHistory
  attr_reader :records

  def self.build(user)
    service = new(user)
    service.run
    service
  end

  def initialize(user)
    @user = user
  end

  def run
    @records = build_games
  end

  private

  attr_reader :user, :game_scores

  def get_scores
    @game_scores = user.scores.includes(:game)
  end

  def build_games
    user.get_my_games.map do |game|
      GamePresenter.new(game, user)
    end
  end
end

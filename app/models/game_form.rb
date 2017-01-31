class GameForm
  include ActiveModel::Model

  attr_reader :owner

  def self.build(owner, attrs = {})
    service = new(owner, attrs)
    service
  end

  def initialize(owner, attrs)
    @owner = owner
    @attrs = attrs
  end

  def opponents_list
    User.where.not(id: owner.id)
  end

  def save(game_params = {})
    @game_params = game_params
    persist_records
  end

  private

  def persist_records
    begin
      ActiveRecord::Base.transaction do
        game = Game.create!(game_fields)

        if game.player_1_score > game.player_2_score
          game.winner = game.player_1
        else
          game.winner = game.player_2
        end


      end
      true
    rescue => e
      errors.add(:game, e.message)
      return false
    end
  end

  def game_fields
    {
        player_1: owner,
        player_1_score: game_params.fetch(:score),

        player_2: User.find(game_params.fetch(:opponent).fetch(:user_id)),
        player_2_score: game_params.fetch(:opponent).fetch(:score),
    }
  end

  def opponent_attrs
    game_params.fetch(:opponent, {})
  end

  def owner_attrs
    {
        user_id: owner.id,
        score: game_params.fetch(:score, 0)
    }
  end

  attr_reader :attrs, :game_params
end
require 'elo'
class ChangeDefaultRatings2 < ActiveRecord::Migration
  def change
  end

  def up
    change_column_default :user, :ratings, Elo.config.default_rating
  end

  def down
    change_column_default :user, :ratings, 0
  end

end

class ChangeDefaultRatings < ActiveRecord::Migration
  def change
  end

  def up
    change_column_default :user, :ratings, 0
  end

  def down
    change_column_default :user, :ratings, nil
  end

end

class AddRatingsToUser < ActiveRecord::Migration
  def change
    add_column :users, :ratings, :Integer
  end
end

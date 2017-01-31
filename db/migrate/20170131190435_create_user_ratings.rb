class CreateUserRatings < ActiveRecord::Migration
  def change
    create_table :user_ratings do |t|
      t.integer :ratings
      t.timestamps null: false
      t.references :user
    end
  end
end

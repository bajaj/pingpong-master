class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :trackable, :validatable

  has_many :players_1, :class_name => 'Game', :foreign_key => 'player_1_id'
  has_many :players_2, :class_name => 'Game', :foreign_key => 'player_2_id'

end

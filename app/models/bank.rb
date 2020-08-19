class Bank < ActiveRecord::Base
  has_many :userbanks
  has_many :users, through: :userbanks

end

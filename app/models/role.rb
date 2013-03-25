class Role < ActiveRecord::Base
  include ParanoiaInterface

  attr_accessible :name, :desc

  has_many :users
end

class Role < ActiveRecord::Base
  include ParanoiaInterface

  attr_accessible :name, :desc

  has_many :users

  def self.default_role
    return Role.find_by_name('athlete')
  end
end

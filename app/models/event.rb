class Event < ActiveRecord::Base
  belongs_to :user
  attr_accessible :deleted_at, :description, :name
end

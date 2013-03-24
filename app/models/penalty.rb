class Penalty < ActiveRecord::Base
  include ParanoiaInterface

  ## Relations ##
  belongs_to :match
  belongs_to :team
  belongs_to :user

  ## Attributes ##
  attr_accessible :description, :end_date, :start_date
end

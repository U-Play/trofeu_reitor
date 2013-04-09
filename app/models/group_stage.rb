class GroupStage < ActiveRecord::Base
  include ParanoiaInterface

  ## Relations ##
  belongs_to :tournament

  ## Attributes ##
  attr_accessible :loss_points, :n_rounds, :tie_points, :win_points, :tournament_id

  ## Validations ##
  validates :tournament, presence: true
  #validates :n_rounds, presence: true
  #validates :loss_points, presence: true
  #validates :tie_points, presence: true
  #validates :win_points, presence: true

end

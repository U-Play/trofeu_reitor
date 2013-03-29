class GroupStage < ActiveRecord::Base
  include ParanoiaInterface

  ## Relations ##
  belongs_to :tournament

  ## Attributes ##
  attr_accessible :loss_points, :n_rounds, :tie_points, :win_points, :tournament_id

  ## Validations ##
  validates :tournament_id, presence: true

end

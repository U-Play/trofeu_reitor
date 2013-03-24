class GroupStage < ActiveRecord::Base
  include ParanoiaInterface

  ## Relations ##
  belongs_to :tournament

  ## Attributes ##
  attr_accessible :deleted_at, :loss_points, :n_rounds, :tie_points, :win_points

  ## Validations ##
  validates :tournament_id, presence: true

end

class GroupStage < ActiveRecord::Base
  belongs_to :tournament
  attr_accessible :deleted_at, :loss_points, :n_rounds, :tie_points, :win_points
end

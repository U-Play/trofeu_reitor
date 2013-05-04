class GroupStage < ActiveRecord::Base
  include ParanoiaInterface

  ## Relations ##
  belongs_to :tournament

  ## Attributes ##
  attr_accessible :draft_made, :loss_points, :n_groups, :n_rounds, :tie_points, :win_points, :tournament_id

  ## Validations ##
  validates :tournament, presence: true
  with_options :if => :is_group_format? do |group|
    group.validates :n_groups, :numericality => {:only_integer => true, :greater_than => 0}
    group.validates :n_rounds, :numericality => {:only_integer => true, :greater_than => 0}
    group.validates :win_points, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0}
    group.validates :tie_points, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0}
    group.validates :loss_points, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0}
  end

  ## Public Methods ##

  def create_groups
    for i in 10..9+self.n_groups do
      self.tournament.groups.create name: "Group #{i.to_s(36).upcase}"
    end
  end

  protected

    def is_group_format?
      return self.tournament.format_id == Format.group_format.id
    end
end

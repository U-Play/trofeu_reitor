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
    group.validate :min_two_teams_per_group
  end

  ## Public Methods ##

  def create_groups
    for i in 10..9+self.n_groups do
      self.tournament.groups.create name: "Group #{i.to_s(36).upcase}"
    end
  end

  def create_matches
    self.tournament.groups.each do |group|
      group_size = group.teams.size
      total_rounds = group_size.even? ? (group_size - 1) * self.n_rounds : group_size * self.n_rounds
      for round in 1..total_rounds do
        for match in 1..(group_size/2).to_f.floor
          group.matches.create :tournament_id => self.tournament.id, :format_id => Format.group_format.id, :group_round => round
        end
      end
    end
  end

  protected

    def is_group_format?
      return self.tournament.format_id == Format.group_format.id
    end

    def min_two_teams_per_group
      if !self.n_groups.nil? && self.n_groups > self.tournament.number_of_teams.to_f/2
        self.tournament.errors.add(:base, 'There should be at least two teams per group')
      end
    end
end

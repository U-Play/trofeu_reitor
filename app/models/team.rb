class Team < ActiveRecord::Base
  include ParanoiaInterface

  ## Relations ##
  belongs_to :tournament
  belongs_to :group
  belongs_to :course
  belongs_to :manager, :class_name => "User"

  has_many :matches_as_team_one, :class_name => "Match", :foreign_key => "team_one_id"
  has_many :matches_as_team_two, :class_name => "Match", :foreign_key => "team_two_id"
  has_many :matches_as_winner, :class_name => "Match", :foreign_key => "winner_id"
  has_many :penalties

  has_many :news_references, :as => :newsable
  has_many :news, through: :news_references

  has_many :team_athletes, :dependent => :destroy, :inverse_of => :team
  has_many :athletes, :through => :team_athletes, :source => :athlete

  has_many :team_referees, :inverse_of => :team
  has_many :referees, :through => :team_referees, :source => :referee

  ## Attributes ##
  attr_accessible :name, :tournament_id, :manager_id, :manager_email, :team_athletes_attributes,
    :team_referees_attributes, :course, :course_id, :group_position, :group_id

  attr_writer :manager_email
  def manager_email
    self.manager.try(:email) || @manager_email
  end

  accepts_nested_attributes_for :team_athletes, :allow_destroy => true
  #accepts_nested_attributes_for :athletes
  accepts_nested_attributes_for :team_referees, :allow_destroy => true

  ## Callbacks ##
  after_save        :set_manager
  before_validation :set_name

  ## Validations ##
  validates :name, :tournament_id, :course, presence: true
  validates :course_id, :uniqueness => { :scope => :tournament_id }
  validate :one_team_one_group
  
  ## Scopes ##
  scope :from_group_and_position, lambda { |group, pos| where(group_id: group, group_position: pos)}

  ## Public Methods ##
  def athletes_per_team
    tournament.sport.athletes_per_team
  end

  def has_athlete?(athlete)
    athletes.any? { |ath| ath.id == athlete.id }
  end

  def matches
    Match.where(:id => (matches_as_team_one + matches_as_team_two))
  end

  def to_s
    name
  end

  def self.clean_position(tournament, group, position)
    team = Team.find_by_tournament_id_and_group_id_and_group_position(tournament, group, position)
    team.update_attributes(:group_id => nil, :group_position => nil) if team
  end

  ## Private Methods ##
  protected

    def one_team_one_group
      if Group.joins(:teams).where('teams.id = ? AND teams.tournament_id = ? AND (teams.group_id != ? OR (teams.group_id = ? AND teams.group_position != ?))', 
                                   self.id, self.tournament_id, self.group_id, self.group_id, self.group_position).any?
        raise "The team #{self.name} cannot be selected more than once"
      end
    end

    def set_manager
      return if @manager_email.nil? || @manager_email.strip.length == 0 || (self.manager && self.manager.email == @manager_email)

      manager = User.find_or_invite_by_email(@manager_email)
      @manager_email = nil
      manager.promote_to_manager(self)

      if manager.course
        if manager.course.id != self.course.id
          errors.add( :manager, "course doesn't match the team's course" ) 
        end
      else
        manager.update_attributes course: self.course
      end

      TeamAthlete.create!( team: self, athlete: manager )
      self.update_attributes manager_id: manager.id
      self.save!
    end

    def set_name
      write_attribute(:name, "#{course.name} - #{tournament.sport.name}")
    end
end

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
    :team_referees_attributes, :course, :course_id

  attr_accessor :manager_email

  accepts_nested_attributes_for :team_athletes, :allow_destroy => true
  #accepts_nested_attributes_for :athletes
  accepts_nested_attributes_for :team_referees, :allow_destroy => true

  ## Callbacks ##
  after_save        :set_manager
  before_validation :set_name

  ## Validations ##
  validates :name, :tournament_id, :course, presence: true
  validates :course_id, :uniqueness => { :scope => :tournament_id }

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

  ## Private Methods ##
  protected

    def set_manager
      return if @manager_email.nil? || @manager_email.strip.length == 0 || (self.manager && self.manager.email == @manager_email)

      manager = User.find_or_invite_by_email(@manager_email)
      @manager_email = nil
      manager.promote_to_manager(self)
      manager.update_attributes course: self.course
      TeamAthlete.create!( team: self, athlete: manager )
      self.update_attributes manager_id: manager.id
      self.save!
    end

    def set_name
      write_attribute(:name, "#{course.name} - #{tournament.sport.name}")
    end
end

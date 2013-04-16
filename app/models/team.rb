class Team < ActiveRecord::Base
  include ParanoiaInterface

  ## Relations ##
  belongs_to :tournament
  belongs_to :group
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
  attr_accessible :deleted_at, :name, :tournament_id, :manager_id, :manager_email, :team_athletes_attributes,
  :team_referees_attributes

  ## Callbacks ##
  after_update :set_manager
  attr_accessor :manager_email

  accepts_nested_attributes_for :team_athletes, :allow_destroy => true
  #accepts_nested_attributes_for :athletes
  accepts_nested_attributes_for :team_referees, :allow_destroy => true

  ## Validations ##
  validates :name, :tournament_id, presence: true


  ## Public Methods ##
  def matches
    Match.where(:id => (matches_as_team_one + matches_as_team_two))
  end

  def has_athlete?(athlete)
    athletes.any? { |ath| ath.id == athlete.id }
  end

  ## Private Methods ##
  protected

    def set_manager
      return if @manager_email.nil? || (self.manager && self.manager.email == @manager_email)

      manager = User.find_or_invite_by_email(@manager_email)
      @manager_email = nil
      manager.promote_to_manager(self)
      self.save!
    end
end

class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :confirmable

  attr_accessible :email, :password, :password_confirmation, :remember_me,
    :first_name, :last_name, :username, :course, :student_number, :sports_number, :picture

  has_attached_file :picture
  # TODO check this configs when possible
  #styles: { medium: "300x300>", thumb: "100x100>" },
  #default_url: "/images/:style/missing.png"

  ## Relations ##
  belongs_to :role

  has_many :events
  has_many :teams_as_coach
  has_many :penalties
  # has_many :news

  has_many :news_references, :as => :newsable
  has_many :news, through: :news_references

  has_many :team_athletes, :dependent => :destroy, :inverse_of => :user
  has_many :teams_as_athlete, :through => :team_athletes

  has_many :team_referees
  has_many :teams_as_referee, :through => :team_referees

  has_many :match_referees
  has_many :matches, :through => :match_referees

  has_many :highlight_occurrences
  has_many :matches, :through => :highlight_occurrences
  has_many :highlights, :through => :highlight_occurrences

  # accepts_nested_attributes_for :team_athletes, :allow_destroy => true

  def name
    full_name = "#{first_name} #{last_name}".strip.presence || email
  end

  def tournaments
    Tournament.joins(:event => :user).where(:events => {:user_id => id})
  end
end

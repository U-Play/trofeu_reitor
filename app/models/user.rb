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
  has_many :teams_as_manager, :class_name => "Team", foreign_key: "manager_id", inverse_of: :manager
  has_many :penalties
  # has_many :news

  has_many :news_references, :as => :newsable
  has_many :news, through: :news_references

  has_many :team_athletes, :dependent => :destroy
  has_many :teams_as_athlete, :through => :team_athletes

  has_many :team_referees
  has_many :teams_as_referee, :through => :team_referees

  has_many :match_referees
  has_many :matches, :through => :match_referees

  has_many :highlight_occurrences
  has_many :matches, :through => :highlight_occurrences
  has_many :highlights, :through => :highlight_occurrences

  # accepts_nested_attributes_for :team_athletes, :allow_destroy => true

  before_create :set_default_role
  after_create :send_invitation_email

  def name
    "#{first_name} #{last_name}".strip.presence || email
  end

  def password_required?
    new_record? ? false : super
  end

  def promote_to_manager
    set_role('manager') if role.nil? || role.name == 'athlete'
    # UserMailer.promoted_to_manager_email(self).deliver
  end

  def tournaments
    Tournament.joins(:event => :user).where(:events => {:user_id => id})
  end

  protected

  def set_role(new_role)
    self.update_attributes role: Role.find_by_name(new_role)
  end

  def set_default_role
    return unless role.nil?
    self.role = Role.default_role
  end

  def send_invitation_email
    # UserMailer.invitation_email(self).deliver
  end
end

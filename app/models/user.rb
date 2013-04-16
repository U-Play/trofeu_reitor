class User < ActiveRecord::Base
  include ParanoiaInterface

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :invitable

  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :first_name, :last_name, :username, :course, :student_nmdevisuber, :sports_number, :picture, :role_id

  has_attached_file :picture
                    # TODO check this configs when possible
                    #styles: { medium: "300x300>", thumb: "100x100>" }

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

  ## Public Methods ##

  before_create :set_default_role
  # after_create :send_invitation_email

  def name
    "#{first_name} #{last_name}".strip.presence || email
  end

  def name_with_team(match)
    if match.team_one.has_athlete?(self)
      "#{name} (#{match.team_one.name})".strip
    elsif match.team_two.has_athlete?(self)
      "#{name} (#{match.team_two.name})".strip
    end
  end

  def password_required?
    new_record? ? false : super
  end

  def promote_to_manager(team)
    set_role('manager') if role.nil? || role.name == 'athlete'
    UserMailer.promoted_to_manager_email(self, team).deliver
  end

  def tournaments
    Tournament.joins(:event => :user).where(:events => {:user_id => id})
  end

  def self.find_or_invite_by_email(email)
    user = User.find_by_email(email)
    return user || User.invite!(email: email)
  end

  protected

    def set_role(new_role)
      self.update_attributes role_id: Role.find_by_name(new_role).id
    end

    def set_default_role
      return unless role.nil?
      self.role = Role.default_role
    end

    #def send_invitation_email
    #  UserMailer.invitation_email(self).deliver
    #end
end

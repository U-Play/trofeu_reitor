class Ability
  include CanCan::Ability

  def initialize(user)
    @user = user
    send user.role.name unless user.nil? || user.role.nil?
  end

  def root
    admin
    can :manage, :all
  end

  def admin
    can :access, :admin
  end

  def validator
    can :access, :admin
  end

  def blogger
    # TODO onde fica a zona admin do blog? no activeadmin?
  end

  def manager
    athlete
    can :access, :admin
  end

  def athlete
    guest
    can [:read, :update], User, id: @user.id
    can :request_validation, User do |user|
      user.id == @user.id && user.can_request_validation?
    end
    # TODO can manage his own profile. vai haver um model Profile ou fica no User?
  end

  def guest
    can :read, User
  end

end

class Ability
  include CanCan::Ability

  def initialize(user)
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
    # TODO can manage his own profile. vai haver um model Profile ou fica no User?
  end

end

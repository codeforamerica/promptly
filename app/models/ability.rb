class Ability
  include CanCan::Ability

  def initialize(user, organization_id)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)
    if user.is_super?
      can :manage, :all
    else
      @organization_user = OrganizationsUser.where(user_id: user.id).where(organization_id: organization_id).first # This should be unique

      if @organization_user
        if @organization_user.has_role? :super
          can :manage, :all
        elsif @organization_user.has_role? :admin
          can :manage, Organization, :organization_id => @organization_user.organization_id
          can :manage, Recipient
          can :manage, Reminder, :organization_id => @organization_user.organization_id
          can :manage, Message, :organization_id => @organization_user.organization_id
          can :manage, Conversation, :organization_id => @organization_user.organization_id
          can :manage, Group, :organization_id => @organization_user.organization_id
        elsif @organization_user.has_role? :user
          # an user can read everything
          can :manage, [Conversation, Recipient]
          # can :manage, Reminder, :organization_id => organization_id
          can :read, Organization, :organization_id => @organization_user.organization_id
          can :manage, Reminder, :organization_id => @organization_user.organization_id
          can :read, Message, :organization_id => @organization_user.organization_id
          can :manage, Conversation, :organization_id => @organization_user.organization_id
          can :manage, Group, :organization_id => @organization_user.organization_id
        elsif @organization_user.has_role? :guest
            #guest can only sign up for the site
          can :read, [User, Page]
        end
      end
    end
    #


    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end

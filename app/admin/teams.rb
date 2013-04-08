ActiveAdmin.register Team do
  menu false

  # Is nested resource of
  belongs_to :tournament

  controller do
    def scoped_collection
      end_of_association_chain.includes(:tournament)
    end
  end

  index do
    column :name
    # column(:tournament, sortable: 'tournament.name') { |team| team.tournament.name }
    column(:manager, sortable: 'user.first_name') { |team| team.manager.name if team.manager }
    column(:group) { |team| team.group.name if team.group }
    default_actions
  end

  show do
    # panel "Menu" do
    #   columns do
    #     column do
    #       ul do
    #         li link_to("Matches", admin_tournament_matches_path(team.tournament.id))
    #       end
    #     end
    #   end
    # end
    attributes_table do
      row :name
      row(:group) { |t| link_to t.group.name, admin_tournament_group_path(t.tournament, t.group) }
      row :manager
    end
    panel "Athletes" do
      table_for team.athletes do 
        column(:name)  { |a| link_to a.name, admin_user_path(a) }
      end
    end
    panel "Referees" do
      table_for team.referees do 
        column(:name)  { |r| link_to r.name, admin_user_path(r) }
      end
    end
    panel "Penalties" do
      table_for team.penalties do 
        column(:name)  { |p| link_to p.name, admin_penalty_path(p) }
        column(:start_date)
        column(:end_date)
      end
    end
    panel "Matches" do
      table_for team.matches do 
        column(:start_date)
        column(:end_date)
        column(:team_one) { |m| link_to m.team_one.name, admin_tournament_team_path(m.tournament, m.team_one) if m.team_one }
        column(:team_two) { |m| link_to m.team_two.name, admin_tournament_team_path(m.tournament, m.team_two) if m.team_two }
      end
    end
  end

  form do |f|
    f.inputs "Required Fields" do
      f.input :name, required: true
      f.input :manager_email, as: :email, required: true
    end
    f.inputs "Athletes" do
      f.has_many :team_athletes do |mr|
        mr.input :athlete

        # if mr.object.persisted?
          mr.input :_destroy, :as => :boolean, :label => "Destroy?"
        # end
      end
    end
    f.inputs "Referees" do
      f.has_many :team_referees do |mr|
        mr.input :referee

        # if mr.object.persisted?
          mr.input :_destroy, :as => :boolean, :label => "Destroy?"
        # end
      end
    end
    f.actions
  end

  filter :name

end

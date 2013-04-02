ActiveAdmin.register Team do
<<<<<<< HEAD
  menu false

  # Is nested resource of
  belongs_to :tournament
=======

  filter :name
>>>>>>> checking for problems

  controller do
    def scoped_collection
      end_of_association_chain.includes(:tournament)
    end
  end

  index do
    column :name
<<<<<<< HEAD
    # column(:tournament, sortable: 'tournament.name') { |team| team.tournament.name }
    column(:manager, sortable: 'user.first_name') { |team| team.manager.name if team.manager }
    column(:group) { |team| team.group.name if team.group }
=======
    column(:tournament, sortable: 'tournament.name') { |team| team.tournament.name }
    column(:coach, sortable: 'user.first_name') { |team| team.coach.name if team.coach }
>>>>>>> checking for problems
    default_actions
  end

  show do
<<<<<<< HEAD
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
      row(:group) { |t| link_to t.group.name, admin_tournament_group_path(t.tournament, t.group) if t.group }
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
        column(:id)  { |m| link_to m.id, admin_tournament_match_path(m.tournament, m) }
        column("Status") { |m| status_tag m.status, m.status_type }
        column(:start_datetime)
        column(:team_one) { |m| link_to m.team_one.name, admin_tournament_team_path(m.tournament, m.team_one) if m.team_one }
        column(:team_two) { |m| link_to m.team_two.name, admin_tournament_team_path(m.tournament, m.team_two) if m.team_two }
        column(:result)
      end
    end
  end

  sidebar "Other Matches For This Team", :only => :show do
    table_for Match.find_all_by_team(team) do
      # column(:status)  { |m| status_tag m.status, m.status_type }
      column(:team_one) { |m| link_to m.team_one.name, admin_tournament_team_path(m.tournament, m.team_one) if m.team_one }
      column(:team_two) { |m| link_to m.team_two.name, admin_tournament_team_path(m.tournament, m.team_two) if m.team_two }
      column(:result)
      column('')     { |m| link_to 'View', admin_tournament_match_path(m.tournament, m) }
=======
    attributes_table do
      row :name
>>>>>>> checking for problems
    end
  end

  form do |f|
    f.inputs "Required Fields" do
<<<<<<< HEAD
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
=======
      f.input :tournament, required: true
      f.input :name
      f.input :manager_email, as: :email, required: true
>>>>>>> checking for problems
    end
    f.actions
  end

<<<<<<< HEAD
  filter :name

=======
>>>>>>> checking for problems
end

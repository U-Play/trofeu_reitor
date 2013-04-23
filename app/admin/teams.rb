ActiveAdmin.register Team do
  # menu :parent => "Administration"

  # Is nested resource of
  belongs_to :tournament

  filter :name

  controller do
    def scoped_collection
      # TODO :manager and :group are being eager loaded unnecessarily on edit
      end_of_association_chain.accessible_by(current_ability).includes(:course, :manager, :group)
    end
  end

  action_item :only => :show do
    link_to('New Team', new_admin_tournament_team_path())
  end

  action_item do
    link_to 'Print Credentials', credentials_admin_tournament_team_path(team.tournament.id, team.id)
  end

  member_action :credentials, method: 'get' do
    Resque.enqueue CredentialWorker, params[:id]
    redirect_to admin_tournament_team_path(params[:tournament_id], params[:id])
  end

  index do
    column :course
    # column(:tournament, sortable: 'tournament.name') { |team| team.tournament.name }
    column(:manager, sortable: 'user.first_name') { |team| team.manager.name if team.manager }
    column(:group) { |team| team.group.name if team.group }
    default_actions
  end

  show title: :course do
    attributes_table do
      row :course
      row(:group) { |t| link_to t.group.name, admin_tournament_group_path(t.tournament, t.group) if t.group }
      row :manager
    end
    panel "Athletes" do
      table_for team.athletes do
        column(:name)  { |a| link_to a.name, admin_user_path(a) }
      end
    end
    # panel "Referees" do
    #   table_for team.referees do
    #     column(:name)  { |r| link_to r.name, admin_user_path(r) }
    #   end
    # end
    panel "Matches" do
      table_for team.matches do
        column(:id)  { |m| link_to m.id, admin_tournament_match_path(m.tournament, m) }
        column("Status") { |m| status_tag m.status, m.status_type }
        column(:start_datetime)
        column(:team_one) { |m| link_to m.team_one.course, admin_tournament_team_path(m.tournament, m.team_one) if m.team_one }
        column(:team_two) { |m| link_to m.team_two.course, admin_tournament_team_path(m.tournament, m.team_two) if m.team_two }
        column(:result)
      end
    end
    panel "Penalties" do
      table_for team.penalties do
        column(:name)  { |p| link_to p.name, admin_penalty_path(p) }
        column(:start_date)
        column(:end_date)
      end
    end
  end

  sidebar "Matches For This Team", :only => :show do
    table_for Match.find_all_by_team(team) do
      # column(:status)  { |m| status_tag m.status, m.status_type }
      column(:team_one) { |m| link_to m.team_one.course, admin_tournament_team_path(m.tournament, m.team_one) if m.team_one }
      column(:team_two) { |m| link_to m.team_two.course, admin_tournament_team_path(m.tournament, m.team_two) if m.team_two }
      column(:result)
      column('')     { |m| link_to 'View', admin_tournament_match_path(m.tournament, m) }
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys

    f.inputs "Required Fields" do
      # f.input :name, required: true
      f.input :course, required: true
      f.input :manager_email, as: :email, required: true
    end

    f.inputs "Athletes" do
      f.has_many :team_athletes do |mr|
        mr.input :athlete_email, as: :email, required: true
        mr.input :_destroy, :as => :boolean, :label => "Destroy?"# if mr.object.persisted?
      end
    end
    # f.inputs "Referees" do
    #   f.has_many :team_referees do |mr|
    #     mr.input :referee_email, as: :email, required: true
    #     mr.input :_destroy, :as => :boolean, :label => "Destroy?"# if mr.object.persisted?
    #   end
    # end
    f.actions
  end

end

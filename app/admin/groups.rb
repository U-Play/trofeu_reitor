ActiveAdmin.register Group do
  menu false

  # Is nested resource of
  belongs_to :tournament

  index do
    column(:name)

    default_actions
  end

  form do |f|
    f.inputs "Group Details" do
      f.input :name, required: true
    end

    f.inputs "Teams" do
      f.input :teams, :as => :select, :collection => Team.find_all_by_tournament_id(params[:tournament_id])
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
    end
    panel "Teams" do
      table_for group.teams do 
        column(:name)     { |t| link_to t.name, admin_tournament_team_path(group.tournament ,t) }
        column(:manager)  { |t| link_to t.manager.name, admin_user_path(t.manager) if t.manager }
      end
    end
  end

  filter :name

end

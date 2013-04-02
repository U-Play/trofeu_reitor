ActiveAdmin.register Tournament do
  menu :parent => "Administration"

  scope_to :current_user

  filter :name

  # Custom Action Items
  action_item :only => :show do
    link_to 'Teams', admin_tournament_teams_path(params[:id])
  end

  action_item :only => :show do
    tournament = Tournament.find(params[:id])
    link_to('Groups', admin_tournament_groups_path(tournament.id)) if tournament.has_group_stage?
  end

  action_item :only => :show do
    link_to 'Matches', admin_tournament_matches_path(params[:id])
  end

  action_item :only => :show do
    tournament = Tournament.find(params[:id])
    #FIXME os seguintes links dao erro
    link_to('Group Stage Configuration', admin_tournament_group_stages_path(tournament.id)) if tournament.has_group_stage?
  end

  action_item :only => :show do
    tournament = Tournament.find(params[:id])
    #FIXME os seguintes links dao erro
    link_to('Knockout Stage Configuration', admin_tournament_knockout_stages_path(tournament.id)) if tournament.has_knockout_stage?
  end

  index do
    column(:name) { |t| link_to t.name, admin_tournament_path(t.id)}
    column(:start_date)
    column(:end_date)
    default_actions
  end

  show do
    attributes_table do
      row :name
      row :sport
      row :event
      row :format
      row :description
      row :rules
      row :start_date
      row :end_date
    end
  end


  form do |f|
    f.inputs "Required Fields" do
      f.input :sport
      f.input :name
      f.input :description
      f.input :rules
      f.input :contacts
      f.input :start_date, as: :datepicker
      f.input :end_date, as: :datepicker
    end
    f.actions
  end

  filter :name

end

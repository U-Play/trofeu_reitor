ActiveAdmin.register Tournament do
  menu :parent => "Administration"

  scope_to :current_user

  index do
    column(:name) { |t| link_to t.name, admin_tournament_path(t.id)}
    column(:start_date)
    column(:end_date)
    default_actions
  end

  show do
    panel "Menu" do
      columns do
        column do
          # panel "Models" do
          ul do
            li link_to("Teams", admin_tournament_teams_path(tournament.id))
            #FIXME os seguintes links dao erro
            li link_to("Matches", admin_tournament_matches_path(tournament.id))
            li link_to("Group Stage Configuration", admin_tournament_group_stages_path(tournament.id))
            li link_to("Knockout Stage Configuration", admin_tournament_knockout_stages_path(tournament.id))
          end
          # end
        end
      end
    end
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

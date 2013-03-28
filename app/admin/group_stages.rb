ActiveAdmin.register GroupStage do
  index do
    column(:tournament) { |gs| link_to gs.tournament.name, admin_tournament_path(gs.tournament) }
    column(:n_rounds)
    column(:loss_points)
    column(:tie_points)
    column(:win_points)

    default_actions
  end
  
  form do |f|
    f.inputs "Group Stage Details" do
      f.input :tournament_id, :as => :select, :collection => Tournament.all, :label_method => :name,
        :value_method => :id, required: true
      f.input :n_rounds
      f.input :loss_points
      f.input :tie_points
      f.input :win_points
    end
    f.actions
  end

  show do
    attributes_table do
      row(:tournament) { |gs| link_to gs.tournament.name, admin_tournament_path(gs.tournament) }
      [:n_rounds, :loss_points, :tie_points, :win_points].each do |column|
        row(column)
      end
    end
  end

  # Filter only by
  filter :tournament_id
end

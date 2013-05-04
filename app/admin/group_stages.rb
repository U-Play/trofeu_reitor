ActiveAdmin.register GroupStage do
  menu false

  # Is nested resource of
  belongs_to :tournament

  index do
    column(:tournament) { |gs| link_to gs.tournament.name, admin_tournament_path(gs.tournament) }
    column(:n_turns)
    column(:n_groups)
    column(:loss_points)
    column(:tie_points)
    column(:win_points)

    default_actions
  end
  
  form do |f|
    f.inputs "Group Stage Details" do
      f.input :tournament, required: true
      f.input :n_turns
      f.input :n_groups
      f.input :loss_points
      f.input :tie_points
      f.input :win_points
    end
    f.actions
  end

  show do
    attributes_table do
      row(:tournament) { |gs| link_to gs.tournament.name, admin_tournament_path(gs.tournament) }
      [:n_turns, :n_groups, :loss_points, :tie_points, :win_points].each do |column|
        row(column)
      end
    end
  end

  # Filter only by
  filter :tournament_id
end

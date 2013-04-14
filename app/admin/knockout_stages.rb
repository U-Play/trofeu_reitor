ActiveAdmin.register KnockoutStage do
  menu false

  # Is nested resource of
  belongs_to :tournament

  index do
    column(:tournament) { |ks| link_to ks.tournament.name, admin_tournament_path(ks.tournament) }
    column(:result_homologation)
    column(:third_place)

    default_actions
  end
  
  form do |f|
    f.inputs "Knockout Stage Details" do
      f.input :tournament, required: true
      f.input :result_homologation, as: :boolean
      f.input :third_place, as: :boolean
    end
    f.actions
  end

  show do
    attributes_table do
      row(:tournament) { |ks| link_to ks.tournament.name, admin_tournament_path(ks.tournament) }
      [:result_homologation, :third_place].each do |column|
        row(column)
      end
    end
  end

  # Filter only by
  filter :tournament_id
  
end

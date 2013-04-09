ActiveAdmin.register Location do
  menu :parent => "Administration"

  index do
    column(:city)

    default_actions
  end

  form do |f|
    f.inputs "Location Details" do
      f.input :city#, :required => true
    end
    f.buttons
  end

  show do
    attributes_table do
      [:city].each do |column|
        row(column)
      end
    end
    panel "Matches" do
      table_for location.matches do 
        column(:id)  { |m| link_to m.id, admin_tournament_match_path(m.tournament, m) }
        column("Status") do |m| 
          status_tag(
            ( ( m.started? && 'Started' ) || ( m.pending? && 'Pending' )  || ( m.ended? && 'Ended' ) ), 
            ( ( m.started? && :error )    || ( m.pending? && :warning )   || ( m.ended? && :ok ) ) 
          )
        end
        column(:start_datetime)
        column(:team_one) { |m| link_to m.team_one.name, admin_tournament_team_path(m.tournament, m.team_one) if m.team_one }
        column(:team_two) { |m| link_to m.team_two.name, admin_tournament_team_path(m.tournament, m.team_two) if m.team_two }
        column(:result)
      end
    end
  end

  # Filter only by
  filter :city

end

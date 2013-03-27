ActiveAdmin.register Location do
  index do
    column :city

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
        column(:id)  { |m| link_to m.id, admin_match_path(m) }
        column(:start_date)
        column(:end_date)
        column(:team_one) { |m| link_to m.team_one.name, admin_team_path(m.team_one) if m.team_one }
        column(:team_two) { |m| link_to m.team_two.name, admin_team_path(m.team_two) if m.team_two }
      end
    end
  end

  # Filter only by
  filter :city

end

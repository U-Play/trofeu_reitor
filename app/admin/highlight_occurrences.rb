ActiveAdmin.register HighlightOccurrence do
  menu false

  index do
    column(:time)
    column(:match)      { |ho| link_to ho.match.start_date, admin_match_path(ho.match) }
    column(:highlight)  { |ho| link_to ho.highlight.name, admin_highlight_path(ho.highlight) }
    column(:athlete)    { |ho| link_to ho.athlete.name, admin_user_path(ho.athlete) }

    default_actions
  end
  
  form do |f|
    f.inputs "Highlight Occurrence Details" do
      f.input :time, required: true#, as: :time_select TODO: tratar este input para ficar mais facil, nem que se tenha que mudar o tipo na DB
      f.input :match, required: true
      f.input :highlight, required: true
      f.input :athlete, required: true # TODO:athletes only
    end
    f.actions
  end

  show do
    attributes_table do
      [:time].each do |column|
        row(column)
      end
      panel "Match" do
        attributes_table_for highlight_occurrence.match do 
          row(:start_date)  { |m| link_to m.start_date, admin_match_path(m)  }
          row(:end_date)    { |m| link_to m.end_date, admin_match_path(m) if m.end_date }
          row(:team_one)    { |m| link_to m.team_one.name, admin_team_path(m.team_one) if m.team_one }
          row(:team_two)    { |m| link_to m.team_two.name, admin_team_path(m.team_two) if m.team_two }
          row(:tournament)  { |m| link_to m.tournament.name, admin_tournament_path(m.tournament) } 
          row(:location)    { |m| link_to m.location.city, admin_location_path(m.location) }
        end
      end
      row(:highlight) { |ho| link_to ho.highlight.name, admin_highlight_path(ho.highlight) }
      row(:athlete)   { |ho| link_to ho.athlete.name, admin_user_path(ho.athlete) }
    end
  end

  # Filter only by
  filter :match_id
  filter :highlight_id
  filter :athlete_id
  
end

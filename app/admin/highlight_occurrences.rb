ActiveAdmin.register HighlightOccurrence do
  index do
    column(:total)
    column(:time)
    column(:match)      { |ho| link_to ho.match.start_date, admin_match_path(ho.match) }
    column(:highlight)  { |ho| link_to ho.highlight.name, admin_highlight_path(ho.highlight) }
    column(:athlete)    { |ho| link_to ho.athlete.name, admin_user_path(ho.athlete) }

    default_actions
  end
  
  form do |f|
    f.inputs "Highlight Occurrence Details" do
      f.input :total, required: true
      f.input :time, required: true#, as: :time_select TODO: tratar este input para ficar mais facil, nem que se tenha que mudar o tipo na DB
      f.input :match_id, :as => :select, :collection => Match.all, :label_method => :start_date,
        :value_method => :id, required: true
      f.input :highlight_id, :as => :select, :collection => Highlight.all, :label_method => :name,
        :value_method => :id, required: true
      f.input :athlete_id, :as => :select, :collection => User.all, :label_method => :name, # TODO:athletes only
        :value_method => :id, required: true
    end
    f.actions
  end

  show do
    attributes_table do
      [:total, :time].each do |column|
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

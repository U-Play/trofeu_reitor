ActiveAdmin.register HighlightOccurrence do
  menu false

  # Is nested resource of
  belongs_to :match

  controller do
    def create
      match = Match.find params[:match_id]
      highlight_occurrence = match.highlight_occurrences.build params[:highlight_occurrence]

      if highlight_occurrence.save
        redirect_to admin_tournament_match_path(match.tournament, match), :notice => 'Highlight successfully added'
      else
        redirect_to :back, alert: 'Some information is missing'
        # render 'admin/matches/show'
        # render controller: 'matches', action: 'show', :id => 5
      end
    end

    def destroy
      HighlightOccurrence.destroy params[:id]
      redirect_to :back
    end
  end

  index do
    column(:time)
    column(:match)      { |ho| link_to ho.match.start_datetime, admin_tournament_match_path(ho.match.tournament, ho.match) }
    column(:highlight)  { |ho| link_to ho.highlight.name, admin_sport_highlight_path(ho.highlight.sport, ho.highlight) }
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
          row("Status")     { |m| status_tag m.status, m.status_type }
          row(:start_datetime)
          row(:team_one)    { |m| link_to m.team_one.name, admin_tournament_team_path(m.tournament, m.team_one) if m.team_one }
          row(:team_two)    { |m| link_to m.team_two.name, admin_tournament_team_path(m.tournament, m.team_two) if m.team_two }
          row(:location)    { |m| link_to m.location.city, admin_location_path(m.location) }
          row(:result)
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

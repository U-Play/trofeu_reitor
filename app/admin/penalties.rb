ActiveAdmin.register Penalty do
  menu false

  # Is nested resource of
  # belongs_to :user
  # belongs_to :athlete#, :class_name => "user"

  index do
    column(:name)
    column(:start_date)
    column(:end_date)
    column(:match)    { |p| link_to p.match.start_date, admin_tournament_match_path(p.match.tournament, p.match) if p.match }
    column(:team)     { |p| link_to p.team.name, admin_tournament_team_path(p.team.tournament, p.team) if p.team }
    column(:athlete)  { |p| link_to p.athlete.name, admin_user_path(p.athlete) if p.athlete }

    default_actions
  end

  form do |f|
    f.inputs "Penalty Details" do
      f.input :name, required: true
      f.input :description
      f.input :start_date, as: :datepicker
      f.input :end_date, as: :datepicker
      f.input :match
      f.input :team
      f.input :athlete # TODO:athletes only
    end
    f.actions
  end

  show do
    attributes_table do
      [:name, :description, :start_date, :end_date].each do |column|
        row(column)
      end
      if (penalty.match)
        panel "Match" do
          attributes_table_for penalty.match do 
            [:start_datetime].each do |column|
              row(column)
            end
            row(:team_one)   { |m| link_to m.team_one.name, admin_tournament_team_path(m.tournament, m.team_one) if m.team_one }
            row(:team_two)   { |m| link_to m.team_two.name, admin_tournament_team_path(m.tournament, m.team_two) if m.team_two }
            row(:result)
            row(:tournament) { |m| link_to m.tournament.name, admin_tournament_path(m.tournament) }
            row(:sport)      { |m| link_to m.tournament.sport.name, admin_sport_path(m.tournament.sport) }
            row(:location)   { |m| link_to m.location.city, admin_location_path(m.location) }
          end
        end
      else
        row(:match)
      end
      row(:team) { |p| link_to p.team.name, admin_tournament_team_path(p.team.tournament, p.team) if p.team }
      row(:athlete) { |p| link_to p.athlete.name, admin_user_path(p.athlete) if p.athlete }
    end
  end

  # Filter only by
  filter :name
  filter :description
  filter :match_id
  filter :team_id
  filter :athlete_id

  # Scopes
  scope :all, :default => true
  scope(:on_going)  { |penalties| penalties.on_going }
  scope(:coming)    { |penalties| penalties.coming }
  scope(:past)      { |penalties| penalties.past }
end

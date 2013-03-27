ActiveAdmin.register Penalty do
  index do
    column(:name)
    column(:start_date)
    column(:end_date)
    column(:match) { |p| link_to p.match.start_date, admin_match_path(p.match) if p.match }
    column(:team) { |p| link_to p.team.name, admin_team_path(p.team) if p.team }
    column(:athlete) { |p| link_to p.athlete.name, admin_user_path(p.athlete) if p.athlete }

    default_actions
  end

  form do |f|
    f.inputs "Penalty Details" do
      f.input :name, required: true
      f.input :description
      f.input :start_date, as: :datepicker
      f.input :end_date, as: :datepicker
      f.input :match_id, :as => :select, :collection => Match.all, :label_method => :start_date,
        :value_method => :id
      f.input :team_id, :as => :select, :collection => Team.all, :label_method => :name,
        :value_method => :id
      f.input :athlete_id, :as => :select, :collection => User.all, :label_method => :name, # TODO:athletes only
        :value_method => :id
    end
    f.actions
  end

  show do
    attributes_table do
      [:name, :description, :start_date, :end_date].each do |column|
        row(column)
      end
      if (penalty.match)
        panel "Match Details" do
          attributes_table_for penalty.match do 
            row("Start Date") { |m| link_to m.start_date, admin_match_path(m)  }
            row("End Date") { |m| link_to m.end_date, admin_match_path(m) if m.end_date }
            row("Team one") { |m| link_to m.team_one.name, admin_team_path(m.team_one) if m.team_one }
            row("Team two") { |m| link_to m.team_two.name, admin_team_path(m.team_two) if m.team_two }
            row("Tournament") { |m| link_to m.tournament.name, admin_tournament_path(m.tournament) } 
            row(:location) { |m| link_to m.location.city, admin_location_path(m.location) }
          end
        end
      else
        row(:match)
      end
      row(:team) { |p| link_to p.team.name, admin_team_path(p.team) if p.team }
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
  scope :on_going do |penalties|
    penalties.where('( start_date <= ? and end_date >= ? ) or (start_date = ? and end_date = ? )', Time.now, Time.now, Time.now, nil)
  end
  scope :coming do |penalties|
    penalties.where('start_date > ?', Time.now)
  end
  scope :past do |penalties|
    penalties.where('end_date < ?', Time.now)
  end
end

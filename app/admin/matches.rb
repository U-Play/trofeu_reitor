ActiveAdmin.register Match do
  menu false

  # Is nested resource of
  belongs_to :tournament

  index do
    # column :group
    column(:start_date)
    column(:end_date)
    column(:team_one) { |m| link_to m.team_one.name, admin_tournament_team_path(m.tournament, m.team_one) if m.team_one }
    column(:team_two) { |m| link_to m.team_two.name, admin_tournament_team_path(m.tournament, m.team_two) if m.team_two }

    default_actions
  end

  form do |f|
    f.inputs "Match Details" do
      f.input :tournament, :required => true
      f.input :location, :required => true
      f.input :winner
      f.input :team_one, :as => :select, :collection => Team.find_all_by_tournament_id(params[:tournament_id])
      f.input :team_two, :as => :select, :collection => Team.find_all_by_tournament_id(params[:tournament_id])
      f.input :group
      f.input :start_date, as: :datepicker
      f.input :end_date, as: :datepicker
    end

    f.inputs "Referees" do
      f.has_many :match_referees do |mr|
        mr.input :referee # it automatically generates a drop-down select to choose from your existing referees
        # mr.input :another_attribute_to_update

        # if mr.object.persisted?
          # show the destroy checkbox only if it is an existing match_referee
          # else, there's already dynamic JS to add / remove new match_referees
          mr.input :_destroy, :as => :boolean, :label => "Destroy?"
        # end
      end
    end
    f.actions
  end

  show do
    attributes_table do
      [:start_date, :end_date, :group].each do |column|
        row(column)
      end
      row(:team_one) { |m| link_to m.team_one.name, admin_team_path(m.team_one) if m.team_one }
      row(:team_two) { |m| link_to m.team_two.name, admin_team_path(m.team_two) if m.team_two }
      row(:tournament) { |m| link_to m.tournament.name, admin_tournament_path(m.tournament) }
      row(:location) { |m| link_to m.location.city, admin_location_path(m.location) }
    end
    panel "Referees" do
      table_for match.referees do 
        column(:name)  { |r| link_to r.name, admin_user_path(r) }
      end
    end
    panel "Penalties" do
      table_for match.penalties do 
        column(:name)  { |p| link_to p.name, admin_penalty_path(p) }
        column(:start_date)
        column(:end_date)
      end
    end
    panel "Highlights" do
      table_for match.highlight_occurrences do 
        column(:time)
        column(:athlete)   { |ho| link_to ho.athlete.name, admin_user_path(ho.athlete) }
        column(:highlight) { |ho| link_to ho.highlight.name, admin_highlight_path(ho.highlight) }
        column(:total)
      end
    end
  end

  # Filter only by
  filter :start_date
  filter :end_date
  # filter :tournament_id
  filter :location_id
  filter :winner_id
  filter :team_one_id
  filter :team_two_id

end

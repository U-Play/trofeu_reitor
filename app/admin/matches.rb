ActiveAdmin.register Match do
  index do
    # column :group
    column(:start_date)
    column(:end_date)
    column(:team_one) { |m| link_to m.team_one.name, admin_team_path(m.team_one) if m.team_one }
    column(:team_two) { |m| link_to m.team_two.name, admin_team_path(m.team_two) if m.team_two }

    default_actions
  end

  form do |f|
    f.inputs "Match Details" do
      f.input :tournament_id, :as => :select, :collection => Tournament.all, :label_method => :name,
              :value_method => :id, :required => true
      f.input :location_id, :as => :select, :collection => Location.all, :label_method => :city,
              :value_method => :id, :required => true
      f.input :winner_id, :as => :select, :collection => Team.all, :label_method => :name,
              :value_method => :id
      f.input :team_one_id, :as => :select, :collection => Team.all, :label_method => :name,
              :value_method => :id
      f.input :team_two_id, :as => :select, :collection => Team.all, :label_method => :name,
              :value_method => :id
      f.input :group
      f.input :start_date, as: :datepicker
      f.input :end_date, as: :datepicker
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
    panel "Penalties" do
      table_for match.penalties do 
        column(:name)  { |p| link_to p.name, admin_penalty_path(p) }
        column(:description)
        column(:start_date)
        column(:end_date)
      end
    end
    panel "Referees" do
      table_for match.referees do 
        column(:name)  { |r| link_to r.name, admin_user_path(r) }
      end
    end
  end

  # Filter only by
  filter :tournament_id
  filter :location_id
  filter :winner_id
  filter :team_one_id
  filter :team_two_id
  
end

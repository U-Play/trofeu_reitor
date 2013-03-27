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

  # show do
  #   attributes_table do
  #     [:start_date, :end_date, :group].each do |column|
  #       row(column)
  #     end
  #     row(:team_one) { |m| link_to m.team_one.name, admin_team_path(m.team_one) if m.team_one }
  #     row(:team_two) { |m| link_to m.team_two.name, admin_team_path(m.team_two) if m.team_two }
  #     row(:tournament) { |m| link_to m.tournament.name, admin_tournament_path(m.tournament) }
  #     row(:location) { |m| link_to m.location.city, admin_location_path(m.location) }
  #   end
  #   panel "Penalties" do
  #     table_for match.penalties do 
  #       column(:name)  { |p| link_to p.name, admin_penalty_path(p) }
  #       column(:description)
  #       column(:start_date)
  #       column(:end_date)
  #     end
  #   end
  #   panel "Referees" do
  #     table_for match.referees do 
  #       column(:name)  { |r| link_to r.name, admin_user_path(r) }
  #     end
  #   end
  # end
end

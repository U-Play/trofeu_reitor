ActiveAdmin.register Match do
  
  menu false

  # Is nested resource of
  belongs_to :tournament

  controller do
    def scoped_collection
      # TODO :tournament is being eager loaded unnecessarily on edit
      end_of_association_chain.includes( {:team_one => :course}, {:team_two => :course}, :tournament)
    end
  end

  # Custom Member Actions
  member_action :begin, :method => :put do
    match = Match.find(params[:id])
    match.begin
    if match.update_attributes params[:match]
      redirect_to admin_tournament_match_path(match.tournament, match), :notice => "Match successfully started!"
    else
      # match.started = false
      # redirect_to admin_tournament_match_path(match.tournament, match), :warning => match.errors.messages
      render :show
    end
  end

  member_action :end, :method => :put do
    match = Match.find(params[:id])
    match.end
    if match.update_attributes params[:match]
      redirect_to edit_admin_tournament_match_path(match.tournament, match), :warning => 'Insert the final result and the winner of this match'
    else
      render :show
    end
  end

  # Custom Action Items
  action_item :only => :show do
    match = Match.find(params[:id])
    if match.pending? && match.ready?
      link_to('Begin Match', begin_admin_tournament_match_path(match.tournament, match), :method => :put, :class => :btn)
    elsif match.started?
      link_to('End Match'  , end_admin_tournament_match_path(match.tournament, match), :method => :put, :class => :btn)
    end
  end

  index do
    column("Status") { |m| status_tag m.status, m.status_type }
    column(:start_datetime)
    column(:team_one) { |m| link_to m.team_one.course, admin_tournament_team_path(m.tournament, m.team_one) if m.team_one }
    column(:team_two) { |m| link_to m.team_two.course, admin_tournament_team_path(m.tournament, m.team_two) if m.team_two }
    column(:result)
    # column(:location) { |m| link_to m.location.city, admin_location_path(m.location) }

    default_actions
  end

  show do
    attributes_table do
      [:start_datetime].each do |column|
        row(column)
      end
      row(:team_one)   { |m| link_to m.team_one.course, admin_tournament_team_path(m.tournament, m.team_one) if m.team_one }
      row(:team_two)   { |m| link_to m.team_two.course, admin_tournament_team_path(m.tournament, m.team_two) if m.team_two }
      row(:result)
      # row(:tournament) { |m| link_to m.tournament.name, admin_tournament_path(m.tournament) }
      row(:sport)      { |m| link_to m.tournament.sport.name, admin_sport_path(m.tournament.sport) }
      # row(:location)   { |m| link_to m.location.city, admin_location_path(m.location) }
    end
    panel 'Game Card' do
      # render :partial => 'game_card', :locals => { match: match }
    end
    panel "Play by Play" do
      render :partial => 'play_by_play', 
        :locals => {
          match: match, 
          highlights: HighlightOccurrence.find_all_by_match_id(match.id) 
        }
    end
    # panel "Referees" do
    #   table_for match.referees do 
    #     column(:name)  { |r| link_to r.name, admin_user_path(r) }
    #   end
    # end
    # panel "Penalties" do
    #   table_for match.penalties do 
    #     column(:name)  { |p| link_to p.name, admin_penalty_path(p) }
    #     column(:start_date)
    #     column(:end_date)
    #   end
    # end
  end

  sidebar "Other Matches In This Tournament", :only => :show do
    table_for Match.find_all_by_tournament_id(match.tournament_id) do
      # column(:status)  { |m| status_tag m.status, m.status_type }
      column(:team_one) { |m| link_to m.team_one.course, admin_tournament_team_path(m.tournament, m.team_one) if m.team_one }
      column(:team_two) { |m| link_to m.team_two.course, admin_tournament_team_path(m.tournament, m.team_two) if m.team_two }
      column(:result)
      column('')     { |m| link_to 'View', admin_tournament_match_path(m.tournament, m) }
    end
  end

  form do |f|
    f.inputs "Match Details" do
      # f.input :location
      #TODO mudar o conteudo do format para algo mais bem feito
      f.input :format, :required => true, :collection => Format.where(:id => [1,2])
      f.input :winner
      f.input :team_one, :as => :select, :collection => Team.find_all_by_tournament_id(params[:tournament_id])
      # f.input :result_team_one
      f.input :team_two, :as => :select, :collection => Team.find_all_by_tournament_id(params[:tournament_id])
      # f.input :result_team_two
      f.input :start_datetime, :as => :just_datetime_picker
    end

    # f.inputs "Referees" do
    #   f.has_many :match_referees do |mr|
    #     mr.input :referee
    #     mr.input :_destroy, :as => :boolean, :label => "Destroy?"
    #   end
    # end
    f.actions
  end

  # Filter only by
  filter :start_datetime
  # filter :location_id
  filter :winner_id
  filter :team_one_id
  filter :team_two_id

end

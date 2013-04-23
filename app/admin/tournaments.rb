ActiveAdmin.register Tournament do
  menu :parent => "Administration"

  filter :name

  controller do
    def scoped_collection
      # TODO :format is being eager loaded unnecessarily on edit
      end_of_association_chain.includes(:format)
    end
  end

  # Custom Action Items
  action_item :only => :show do
    link_to 'Teams', admin_tournament_teams_path(params[:id])
  end

  action_item :only => :show, :if => proc {tournament.has_group_stage?} do
    tournament = Tournament.find(params[:id])
    link_to('Groups', admin_tournament_groups_path(tournament.id))
  end

  action_item :only => :show do
    link_to 'Matches', admin_tournament_matches_path(params[:id])
  end

  action_item :only => :show, :if => proc {tournament.has_group_stage?} do
    tournament = Tournament.find(params[:id])
    #FIXME os seguintes links dao erro
    link_to('Group Stage Configuration', admin_tournament_format_path(tournament.group_stage))
  end

  action_item :only => :show, :if => proc {tournament.has_knockout_stage?} do
    tournament = Tournament.find(params[:id])
    #FIXME os seguintes links dao erro
    link_to('Knockout Stage Configuration', admin_tournament_knockout_stages_path(tournament.id))
  end

  index do
    column(:name)  { |t| link_to t.name, admin_tournament_path(t.id)}
    column(:sport) { |t| link_to t.sport.name, admin_sport_path(t.sport_id)}
    column :number_of_teams, :label => 'Number of Teams' 
    column(:format) { |t| link_to t.format.name, admin_tournament_format_path(t.format) if t.format }
    column :start_date
    column :end_date
    default_actions
  end

  show do
    attributes_table do
      row :name
      row :sport
      row :event
      row :format
      row :description
      row :rules
      row :start_date
      row :end_date
    end
  end

  form do |f|
    f.inputs "Required Fields" do
      f.input :sport
      f.input :name
      if !f.object.new_record?
        f.input :rules
      end
      f.input :description
      f.input :contacts
      if !f.object.new_record?
        f.input :start_date, as: :datepicker
        f.input :end_date, as: :datepicker
      end
    end
    f.actions
  end

  #TODO: TESTAR SE O DRAFT JA FOI FEITO
  action_item :only => :show, :if => proc{ tournament.group_stage} do
    link_to 'Groups Draft', :controller => "tournaments", :action => "groups_draft", :id => tournament.id
  end

  member_action :groups_draft, :method => :get do
    @tournament = Tournament.find(params[:id])
    @teams = @tournament.teams
    @groups = @tournament.groups
  end

  # Save the draft
  member_action :save_groups_draft, :method => :post do
  end

  #Save the manual draft made
  member_action :save_knockout_draft, :method => :post do
    selected_teams = []
    @tournament = Tournament.find(params[:id])
    params[:matches].each do |match,teams|
      selected_teams << teams[0] if !teams[0].blank?
      selected_teams << teams[1] if !teams[1].blank?
    end
    if selected_teams.uniq.length == selected_teams.length
      params[:matches].each do |match,teams|
        @tournament.matches.find(match).update_attributes(:team_one_id => teams[0], :team_two_id => teams[1])
      end
      @tournament.knockout_stage.set_exempt_winners if selected_teams.length == @tournament.number_of_teams
      redirect_to admin_tournament_path(@tournament)
    else
      @tournament.errors[:base] << "The same team cannot be selected for two different matches!"
      @teams = @tournament.teams
      render :show_knockout_draft
    end
  end

  action_item :only => :show, :if => proc{ tournament.knockout_stage && !tournament.knockout_stage.draft_made? } do 
    link_to 'Knockout Draft', :controller => "tournaments", :action => "knockout_draft", :id => tournament.id
  end 

  #Action to show the page where the admin can do the manual draft
  member_action :knockout_draft, :method => :get do
    @tournament = Tournament.find(params[:id])
    @teams = @tournament.teams
  end

  action_item :only => :show, :if => proc{ tournament.has_teams? } do 
    link_to 'Begin Tournament', :controller => "tournaments", :action => "final_configuration", :id => tournament.id
  end 

  member_action :final_configuration, :method => :get do
    @tournament = Tournament.find(params[:id])
  end

  member_action :begin_tournament, :method => :put do
    @tournament = Tournament.find(params[:id])
    params[:tournament].store(:number_of_teams, @tournament.teams.size)

    if params[:tournament][:format_id].blank?
      @tournament.errors.add(:format_id, "can't be blank")
      render :final_configuration
    elsif params[:tournament][:number_of_teams] <= 1
      @tournament.errors.add(:base, "The tournament should have at least 2 teams")
      render :final_configuration
    elsif @tournament.update_attributes(params[:tournament])
      @tournament.elaborate_format
      redirect_to admin_tournament_path(@tournament)
    else
      render :final_configuration
    end
  end

  action_item :only => :show, :if => proc{ !tournament.knockout_stage.nil? && tournament.knockout_stage.actual_stage_finished?} do
    link_to 'Generate Next Stage', {:controller => "tournaments", :action => "next_stage", :id => tournament.id}, :method => :post
  end

  #Action that will update the matches with teams that go to the next stage
  member_action :next_stage, :method => :post do
    @tournament = Tournament.find(params[:id])
    @tournament.knockout_stage.update_next_stage
    redirect_to admin_tournament_path(@tournament)
  end

end

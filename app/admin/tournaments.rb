ActiveAdmin.register Tournament do

  controller do
    
    def create
      @tournament = Tournament.new params[:tournament]
    
      if @tournament.save
        #If tournament is successfully saved, it will create the number of teams that are going to participate
        @tournament.create_teams
        #Depending on the type of format, it will create the according matches
        #Format: Group Stage
        if @tournament.format_id == 1
          puts "NOT IMPLEMENTED"
        #Format: Knockout Stage
        elsif @tournament.format_id == 2
          @tournament.create_knockout_matches
        #Format: Mixed Stage
        elsif @tournament.format_id == 3
          puts "NOT IMPLEMENTED"
        end
        redirect_to admin_tournaments_path
      else
        render :new
      end
    end
  end

  filter :name

  index do
    column :name
    column :number_of_teams
    column(:format) { |t| link_to t.format.name, admin_team_path(t.format) if t.format }
    column :start_date
    column :end_date
    default_actions
  end

  show do
    attributes_table do
      row :sport
      row :name
      row :start_date
      row :end_date
    end
  end

  form do |f|
    f.inputs "Required Fields" do
      f.input :sport
      f.input :name
      f.input :format
      f.inputs "Group Stage" do
        f.semantic_fields_for :group_stage, (f.object.group_stage || f.object.build_group_stage) do |gs|
          gs.inputs do
            gs.input :n_rounds
            gs.input :loss_points
            gs.input :tie_points
            gs.input :win_points
          end
        end
      end
      f.inputs "Knockout Stage" do
        f.semantic_fields_for :knockout_stage, (f.object.knockout_stage || f.object.build_knockout_stage) do |ks|
          ks.inputs do
            ks.input :result_homologation
            ks.input :third_place
          end
        end
      end
      f.input :number_of_teams
      f.input :description
      f.input :rules
      f.input :contacts
      f.input :start_date, as: :datepicker
      f.input :end_date, as: :datepicker
    end
    f.actions
  end

  #Save the manual draft made
  member_action :save_draft, :method => :post do
    selected_teams = []
    @tournament = Tournament.find(params[:id])
    params[:matches].each do |k,v|
      selected_teams << v[0] if !v[0].blank?
      selected_teams << v[1] if !v[1].blank?
    end
    if selected_teams.uniq.length == selected_teams.length
      params[:matches].each do |k,v|
        @tournament.matches.find(k).update_attributes(:team_one_id => v[0], :team_two_id => v[1])
      end
      if selected_teams.length == @tournament.number_of_teams
        first_games = (2 ** @tournament.number_of_stages)/2
        for position in 1..first_games do
          match = @tournament.matches.find_by_position(position)
          if match.team_one_id.nil? && !match.team_two_id.nil?
            match.update_attributes(:winner_id => match.team_two_id)
          elsif !match.team_one_id.nil? && match.team_two_id.nil?
            match.update_attributes(:winner_id => match.team_one_id)
          end
        end
      end
      redirect_to admin_tournament_path(@tournament)
    else
      @tournament.errors[:base] << "The same team cannot be selected for two different matches!"
      @teams = @tournament.teams
      render :show_manual_draft
    end
  end

  action_item :only => :show, :if => proc{ !tournament.draft_made? } do 
    link_to 'Manual Draft', :controller => "tournaments", :action => "show_manual_draft", :id => tournament.id
  end 

  #Action to show the page where the admin can do the manual draft
  member_action :show_manual_draft, :method => :get do
    @tournament = Tournament.find(params[:id])
    @teams = @tournament.teams
  end
  
  action_item :only => :show, :if => proc{ !tournament.knockout_stage.nil? && tournament.actual_stage_finished?} do
    link_to 'Generate Next Stage', {:controller => "tournaments", :action => "next_stage", :id => tournament.id}, :method => :post
  end

  #Action that will update the matches with teams that go to the next stage
  member_action :next_stage, :method => :post do
    @tournament = Tournament.find(params[:id])
    @tournament.update_next_stage
    redirect_to admin_tournament_path(@tournament)
  end

end

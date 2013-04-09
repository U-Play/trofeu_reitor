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
        f.semantic_fields_for :group_stage, f.object.build_group_stage do |gs|
          gs.inputs do
            gs.input :n_rounds
            gs.input :loss_points
            gs.input :tie_points
            gs.input :win_points
          end
        end
      end
      f.inputs "Knockout Stage" do
        f.semantic_fields_for :knockout_stage, f.object.build_knockout_stage do |ks|
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

  #Action to show the page where the admin can do the manual draft
  member_action :show_manual_draft, :method => :get do
    @tournament = Tournament.find(params[:id])
    @teams = @tournament.teams
  end

  action_item :only => :show, :if => proc{ !tournament.draft_made? } do 
    link_to 'Manual Draft', :controller => "tournaments", :action => "show_manual_draft", :id => tournament.id
  end 

  #Action that will update the matches with teams that go to the next stage
  member_action :next_stage, :method => :post do
    @tournament = Tournament.find(params[:id])
  end

  action_item :only => :show do
    link_to 'Generate Next Stage', :controller => "tournaments", :action => "next_stage", :id => tournament.id
  end

end

class TournamentsController < ApplicationController

  def index
    @tournaments = Tournament.all
  end

  def new
    @tournament = Tournament.new
    @formats = Format.all
  end

  def create
    @tournament = Tournament.new params[:tournament]
    
    if @tournament.save
      #If tournament is successfully saved, it will create the number of teams that are going to participate
      number_of_teams = params[:number_teams].to_i
      @tournament.create_teams(number_of_teams)
      #Depending on the type of format, it will create the according matches
      if @tournament.format_id == 1
        puts "NOT IMPLEMENTED"
      elsif @tournament.format_id == 2
        @tournament.create_knockout
        number_of_stages = Tournament.number_of_stages(number_of_teams)
        number_of_slots = 2 ** number_of_stages
        random_draft = (0..number_of_teams-1).to_a.shuffle!
        i = 1
        #First phase
        (number_of_slots/2).times do
          if random_draft[i + (number_of_slots/2) - 1].nil?
            @tournament.matches.create position: i, team_one_id: @tournament.teams[random_draft[i-1]].id
          else
            @tournament.matches.create position: i, team_one_id: @tournament.teams[random_draft[i-1]].id, 
                                     team_two_id: @tournament.teams[random_draft[i + (number_of_slots/2) - 1]].id
          end
          i += 1
        end
      elsif @tournament.format_id == 3
        puts "NOT IMPLEMENTED"
      end
      redirect_to tournaments_path
    else
      render :new
    end

  end

end

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
      i = 1
      params[:number_teams].to_i.times do
        @tournament.teams.create :name => "Team " << i.to_s 
        i += 1
      end
      
      #Depending on the type of format, it will create the according matches
      if @tournament.format_id == 1
      elsif @tournament.format_id == 2
      elsif @tournament.format_id == 3
      end
      redirect_to tournaments_path
    else
      render :new
    end

  end

end

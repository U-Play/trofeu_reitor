class TournamentsController < ApplicationController

  def index
    @tournaments = Tournament.all
  end

  def new
    @tournament = Tournament.new
  end

  def create
    @tournament = Tournament.new params[:tournament]
    
    if @tournament.save
      i = 1
      params[:number_teams].to_i.times do
        Team.create :name => "Team " << i.to_s, :tournament => @tournament
        i += 1
      end
      redirect_to tournaments_path
    else
      render :new
    end

  end

end

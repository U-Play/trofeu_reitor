class KnockoutStage < ActiveRecord::Base
  include ParanoiaInterface

  ## Relations ##
  belongs_to :tournament

  ## Attributes ##
  attr_accessible :result_homologation, :third_place, :tournament_id

  ## Validations ##
  validates :tournament, presence: true

  ## Public Methods ##

  #Check if the initial draft has already been made
  def draft_made?
    teams_drafted = 0
    self.tournament.teams.each do |t|
      teams_drafted += 1 unless t.match_as_team_one.empty? && t.match_as_team_two.empty? 
    end
    return self.tournament.number_of_teams == teams_drafted 
  end

  def actual_stage_finished?
    # The last stage is stage 0
    number_of_stages = self.number_of_stages - 1
    positions = []
    position = 0
    number_of_stages.downto(1) do |i|
      position += 2 ** i
      positions << position
    end
    games_finished = self.tournament.matches.finished.size
    #Also test if the next stage is set
    return positions.include?(games_finished) && self.tournament.matches.find_by_position(games_finished + 1).team_one_id.nil?
  end

  #Based on the number of teams, get the number of stages that the tournament will have
  def number_of_stages
    for number_of_stages in 0..self.tournament.number_of_teams
      break if self.tournament.number_of_teams <= 2 ** number_of_stages
    end
    return number_of_stages
  end

  #Set the winner of the match for the matches with only one team (can only happen in knockout)
  def set_exempt_winners
    first_games = (2 ** self.number_of_stages) / 2
    for position in 1..first_games
      match = self.tournament.matches.find_by_position(position)
      if match.team_one_id.nil? && !match.team_two_id.nil?
        match.update_attributes(:winner_id => match.team_two_id)
      elsif !match.team_one_id.nil? && match.team_two_id.nil?
        match.update_attributes(:winner_id => match.team_one_id)
      end
    end
  end

  #According to the configurations, create the necessary matches that will be played 'till the final one
  def create_knockout_matches
    number_of_stages = self.number_of_stages
    if self.third_place
      number_of_games = 2 ** number_of_stages
    else
      number_of_games = (2 ** number_of_stages) - 1 
    end
    i = 1
    #Create all Games
    number_of_games.times do
      self.tournament.matches.create position: i
      i += 1
    end
  end

  ##Will check at what stage the tournament is and prepare the games (get the winning teams) of the next stage
  def update_next_stage
    number_of_stages = self.number_of_stages - 1
    games_finished = self.tournament.matches.finished.size
    acc = 0
    next_stage = number_of_stages
    number_of_stages.downto(0) do |i|
      acc += 2 ** i
      #As the stages advance, the number that represents it decreases (final stage is 0)
      next_stage = i - 1
      break if games_finished == acc
    end
    first_game_stage = acc + 1
    #Get the number of games made in the actual stage (minus one) and add to the first position of the next stage
    last_game_stage = first_game_stage + ((2 ** (next_stage + 1)) / 2) - 1
    acc = 0
    for position in first_game_stage..last_game_stage
      first_match = self.tournament.matches.find_by_position(position - (2 ** (next_stage + 1)) + acc)
      second_match = self.tournament.matches.find_by_position(position - (2 ** (next_stage + 1)) + acc + 1)
      if next_stage == 0 && self.third_place
        self.tournament.matches.find_by_position(position).update_attributes(:team_one_id => first_match.loser.id, :team_two_id => second_match.loser.id)
        self.tournament.matches.find_by_position(position + 1).update_attributes(:team_one_id => first_match.winner_id, :team_two_id => second_match.winner_id)
      else
        self.tournament.matches.find_by_position(position).update_attributes(:team_one_id => first_match.winner_id, :team_two_id => second_match.winner_id)
      end
      acc += 1
    end
  end

end
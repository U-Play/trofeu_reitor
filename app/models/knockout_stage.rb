class KnockoutStage < ActiveRecord::Base
  include ParanoiaInterface

  ## Relations ##
  belongs_to :tournament

  ## Attributes ##
  attr_accessible :result_homologation, :third_place, :tournament_id

  ## Validations ##
  validates :tournament, presence: true

  ## Public Methods ##

  def draft_made?
    teams_drafted = 0
    self.tournament.teams.each do |t|
      teams_drafted += 1 unless t.match_as_team_one.empty? && t.match_as_team_two.empty? 
    end
    return self.tournament.number_of_teams == teams_drafted 
  end

  def actual_stage_finished?
    #Don't address the final
    last_positions = self.last_position_of_each_stage(1)
    games_finished = self.tournament.matches.finished.size
    #Also test if the next stage has already been set
    return last_positions.include?(games_finished) && self.tournament.matches.find_by_position(games_finished + 1).team_one_id.nil?
  end

  def last_position_of_each_stage(last_stage = 0)
    number_of_stages = self.number_of_stages - 1
    positions = []
    position = 0
    number_of_stages.downto(last_stage) do |i|
      position += 2 ** i
      positions << position
    end
    return positions.reverse
  end

  def number_of_first_games
    return 2 ** (self.number_of_stages-1)
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
    for position in 1..self.number_of_first_games
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
    position = 1
    #Create all Games
    number_of_games.times do
      self.tournament.matches.create position: position, knockout_index: stage_of_position(position)
      position += 1
    end
  end

  def stage_of_position(position)
    last_positions = self.last_position_of_each_stage
    return 0 if position >= last_positions[0] 
    for index in 1..(last_positions.length - 2)
      return index if position <= last_positions[index] && position > last_positions[index + 1]
    end
    return (last_positions.length - 1)
  end

  ##Will check at what stage the tournament is and prepare the games (get the winning teams) of the next stage
  def update_next_stage
    games_finished = self.tournament.matches.finished.size
    last_positions = self.last_position_of_each_stage
    next_stage = last_positions.index(games_finished) - 1
    first_game_stage = games_finished + 1
    #Get the number of games made in the actual stage (minus one) and add to the first position of the next stage
    last_game_stage = first_game_stage + ((2 ** (next_stage + 1)) / 2) - 1
    self.set_next_stage_matches(first_game_stage, last_game_stage, next_stage)
  end

  def set_next_stage_matches(first_game_stage, last_game_stage, next_stage)
    acc = 0
    for position in first_game_stage..last_game_stage
      previous_position = position - (2 ** (next_stage + 1)) + acc
      first_match = self.tournament.matches.find_by_position(previous_position)
      second_match = self.tournament.matches.find_by_position(previous_position + 1)
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

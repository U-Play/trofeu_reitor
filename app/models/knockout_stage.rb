class KnockoutStage < ActiveRecord::Base
  include ParanoiaInterface

  ## Relations ##
  belongs_to :tournament

  ## Attributes ##
  attr_accessible :draft_made, :result_homologation, :third_place, :tournament_id

  ## Validations ##
  validates :tournament, presence: true

  ## Public Methods ##

  def actual_stage_finished?
    #Don't address the final stage
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

  #Based on the number of teams, get the number of stages that the tournament will have
  def number_of_stages
    number_of_stages = 0
    until self.tournament.number_of_teams <= 2 ** number_of_stages
      number_of_stages += 1
    end
    return number_of_stages
  end

  #Set the winner of the match for the matches with only one team (can only happen in knockout)
  def set_exempt_winners
    self.tournament.matches.stage(self.number_of_stages - 1).each do |m|
      if m.team_one_id.nil? && !m.team_two_id.nil?
        m.update_attributes(:winner_id => m.team_two_id)
      elsif !m.team_one_id.nil? && m.team_two_id.nil?
        m.update_attributes(:winner_id => m.team_one_id)
      end
    end
  end

  #According to the configurations, create the necessary matches that will be played 'till the final one
  def create_knockout_matches
    position = 1
    #Create all Games
    self.tournament_games.times do
      self.tournament.matches.create position: position, knockout_index: stage_of_position(position), format_id: Format.knockout_format.id
      position += 1
    end
  end

  def tournament_games
    number_stages = self.number_of_stages
    if self.third_place && self.tournament.number_of_teams > 3
      number_of_games = 2 ** number_stages
    else
      number_of_games = (2 ** number_stages) - 1
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
    self.set_next_stage_matches(next_stage)
  end

  def set_next_stage_matches(next_stage)
    acc = 0
    third_place_done = false
    first_winner_id = nil
    second_winner_id = nil
    self.tournament.matches.stage(next_stage).each do |m|
      previous_position = m.position - (2 ** (next_stage + 1)) + acc
      first_match = self.tournament.matches.find_by_position(previous_position)
      second_match = self.tournament.matches.find_by_position(previous_position + 1)
      if next_stage == 0 && self.third_place && !third_place_done
        m.update_attributes(:team_one_id => first_match.loser.id, :team_two_id => second_match.loser.id)
        first_winner_id = first_match.winner_id
        second_winner_id = second_match.winner_id
        third_place_done = true
      else
        m.update_attributes(:team_one_id => (first_winner_id || first_match.winner_id), :team_two_id => (second_winner_id || second_match.winner_id))
      end
      acc += 1
    end
  end

end

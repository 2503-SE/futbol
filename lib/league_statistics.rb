module LeagueStatistics
  def best_offense
    total_goals = {}
    games_played = {}

    @game_teams.each do |game_team|
      team_id = game_team.team_id

      if total_goals[team_id].nil?
        total_goals[team_id] = game_team.goals
        games_played[team_id] = 1
      else
        total_goals[team_id] += game_team.goals
        games_played[team_id] += 1
      end
    end

    highest_avg = 0
    best_team_id = nil

    total_goals.each do |team_id, goals|
      average = goals.to_f / games_played[team_id]
      if average > highest_avg
        highest_avg = average
        best_team_id = team_id
      end
    end

    team_name(best_team_id)
  end

  def best_defense
    total_goals_allowed = {}
    games_played = {}

    @game_teams.each do |game_team|
      team_id = game_team.team_id

      if total_goals_allowed[team_id].nil?
        total_goals_allowed[team_id] = game_team.goals_allowed
        games_played[team_id] = 1
      else
        total_goals_allowed[team_id] += game_team.goals_allowed
        games_played[team_id] += 1
      end
    end

    lowest_avg = Float::INFINITY
    best_defensive_team_id = nil

    total_goals_allowed.each do |team_id, goals_allowed|
      average = goals_allowed.to_f / games_played[team_id]
      if average < lowest_avg
        lowest_avg = average
        best_defensive_team_id = team_id
      end
    end

    team_name(best_defensive_team_id)
  end

  def highest_scoring_visitor
    total_away_goals = Hash.new(0)

    @game_teams.each do |game_team|
      if game_team.hoa == 'away'
        total_away_goals[game_team.team_id] += game_team.goals
      end
    end

    highest_goals = total_away_goals.values.max
    best_team_id = total_away_goals.key(highest_goals)

    team_name(best_team_id)
  end

  def highest_scoring_home_team
    total_home_goals = Hash.new(0)

    @game_teams.each do |game_team|
      if game_team.hoa == 'home'
        total_home_goals[game_team.team_id] += game_team.goals
      end
    end

    highest_goals = total_home_goals.values.max
    best_team_id = total_home_goals.key(highest_goals)

    team_name(best_team_id)
  end

  def lowest_scoring_visitor
    total_away_goals = Hash.new(0)

    @game_teams.each do |game_team|
      if game_team.hoa == 'away'
        total_away_goals[game_team.team_id] += game_team.goals
      end
    end

    lowest_goals = total_away_goals.values.min
    worst_team_id = total_away_goals.key(lowest_goals)

    team_name(worst_team_id)
  end

  def lowest_scoring_home_team
    total_home_goals = Hash.new(0)

    @game_teams.each do |game_team|
      if game_team.hoa == 'home'
        total_home_goals[game_team.team_id] += game_team.goals
      end
    end

    lowest_goals = total_home_goals.values.min
    worst_team_id = total_home_goals.key(lowest_goals)

    team_name(worst_team_id)
  end

  private

  def team_name(team_id)
    @teams.find { |team| team.team_id == team_id }.team_name
  end
end
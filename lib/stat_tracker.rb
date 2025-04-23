require 'CSV'
require_relative './game'
require_relative './team'
require_relative './game_team'
# require_relative './game_factory'
# require_relative './team_factory'
# require_relative './game_team_factory'
# require_relative './lib/game_statistics'
# require_relative './lib/league_statistics'
# require_relative './lib/season_statistics'

class StatTracker

    # include GameStatistics, LeagueStatistics, SeasonStatistics

    attr_reader :games, :teams, :game_teams
    
    def initialize(games, teams, game_teams)
        @games = games
        @teams = teams
        @game_teams = game_teams
    end

    def self.from_csv(locations)
        games = CSV.read(locations[:games], headers: true, header_converters: :symbol).map { |row| Game.new(row) }
        teams = CSV.read(locations[:teams], headers: true, header_converters: :symbol).map { |row| Team.new(row) }
        game_teams = CSV.read(locations[:game_teams], headers: true, header_converters: :symbol).map { |row| GameTeam.new(row) }

        StatTracker.new(games, teams, game_teams)
    end

    def highest_total_score
        @games.map do |game|
            game.home_goals + game.away_goals
        end.max
    end

    def lowest_total_score
        @games.map do |game|
            game.home_goals + game.away_goals
        end.min
    end

    def percentage_home_wins
        total_games = @games.length
        home_wins = @games.count do |game|
            game.home_goals > game.away_goals
        end
        (home_wins.to_f / total_games).round(2)

    end
    
    def percentage_visitor_wins
        total_games = @games.length
        visitor_wins = @games.count do |game|
            game.away_goals > game.home_goals
        end
        (visitor_wins.to_f / total_games).round(2)

    end

    def percentage_ties
        total_games = @games.length
        ties = @games.count do |game|
          game.home_goals == game.away_goals
        end

        (ties.to_f / total_games).round(2)
    end

    def count_of_games_by_season
        counts = Hash.new(0)
        @games.each do |game|
          counts[game.season] += 1
        end
        counts
    end
    
    def average_goals_per_game
        total_goals = 0
        @games.each do |game|
            total_goals += game.home_goals + game.away_goals
        end
        (total_goals.to_f / @games.length).round(2)

    end

    def average_goals_by_season
        season_totals = Hash.new do |hash, key| 
            hash[key] = { goals: 0, games: 0 } 
        end
      
        @games.each do |game|
          season = game.season
          total_goals = game.home_goals + game.away_goals
          season_totals[season][:goals] += total_goals
          season_totals[season][:games] += 1
        end
      
        averages = {}

        season_totals.each do |season, data|
          averages[season] = (data[:goals].to_f / data[:games]).round(2)
        end
      
        averages
    end
end
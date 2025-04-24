require 'CSV'
require_relative './game'
require_relative './team'
require_relative './game_team'
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

    #Game Statistics - Will
    
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

    #League Statistics - Austin



    #Season Statistics - Nick

    # helper method for accessing all of the games for a given season
    def game_team_seasons(season)

        @game_teams.select do |game_team|
            # Loop through each GameTeam object (instantiated rows from parsed .csv files)
          game = @games.find do |game|
            # For each GameTeam, find the matching Game object by game_id (on a given row from each spreadsheet)
            game.game_id == game_team.game_id
          end
        
        game && game.season == season
        # Then, only include this GameTeam if the matching Game exists AND the season matches
        end
    end

    # Returns the ame of the head coach with the best win percentage for a given season
    def winningest_coach(season)
        # Filter game_team rows that belong to the given season
        game_team_rows_in_season = game_team_seasons(season)

        #Create a hash to track each coach's total games and wins
        coach_records = Hash.new do |coach_record, coach| 
            coach_record[coach] = { :wins => 0, :total => 0 }
        end

        # Iterate through each GameTeam row for the season
        game_team_rows_in_season.each do |game_team|
            coach = game_team.head_coach
            
            # Increment the total games played for that coach regardless if result is "WIN" or "LOSS"
            coach_records[coach][:total] += 1
            
            # Increment wins only if the result is "WIN"
            coach_records[coach][:wins] += 1 if game_team.result == "WIN"
        end

            # Find the coach with the highest win percentage (game wins / total games)
        coach_records.max_by do |coach, season_stats|
            season_stats[:wins].to_f / season_stats[:total]
        end.first
    end

    # Returns the name of the head coach with the lowest win percentage for a given season
    # same as #winningest_coach except using coach_records.min_by instead of coach_records.max_by
    def worst_coach(season)
        game_team_rows_in_season = game_team_seasons(season)

        coach_records = Hash.new do |coach_record, coach| 
            coach_record[coach] = { :wins => 0, :total => 0 }
        end
    
        game_team_rows_in_season.each do |game_team|
            coach = game_team.head_coach
            coach_records[coach][:total] += 1
            coach_records[coach][:wins] += 1 if game_team.result == "WIN"
        end

        # Find the coach with the lowest win percentage (game wins / total games)
        coach_records.min_by do |coach, season_stats|
            season_stats[:wins].to_f / season_stats[:total]
        end.first
    end

    def most_accurate_team

    end

    def least_accurate_team

    end

    def most_tackles

    end

    def fewest_tackles

    end


end
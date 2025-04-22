require 'CSV'
require './lib/stat_tracker'

game_path = './data/games.csv'
team_path = './data/teams.csv'
game_teams_path = './data/game_teams.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}

stat_tracker = StatTracker.from_csv(locations)

# added these here to confirm that we are now successfully dealing with
# the actual objects and no longer dealing with CSV::Row directly
puts stat_tracker.games.first.class      
# => Game
puts stat_tracker.teams.first.class      
# => Team
puts stat_tracker.game_teams.first.class 
# => GameTeam
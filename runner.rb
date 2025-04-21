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

# require 'pry'; binding.pry

CSV.foreach(locations[:games], headers: true, header_converters: :symbol) do |row|

  locations = StatTracker.new(
    row[:game_id].to_i,
    row[:team_id].to_i,
    row[:hoa],
    row[:result],
    row[:settled_in],
    row[:head_coach],
    row[:goals].to_i,
    row[:shots].to_i,
    row[:tackles].to_i,
    row[:pim].to_i,
    row[:power_play_opportunities].to_i,
    row[:power_play_goals].to_i,
    row[:face_off_win_percentage].to_f,
    row[:giveaways].to_i,
    row[:takeaways].to_i
  )
end
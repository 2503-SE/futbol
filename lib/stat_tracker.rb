require 'csv'

class StatTracker
    
    def initialize(stat_tracker)
        @stat_tracker = stat_tracker
    end

    def self.from_csv(locations)
        games = CSV.read(locations[:games], headers: true, header_converters: :symbol)
        teams = CSV.read(locations[:teams], headers: true, header_converters: :symbol)
        game_teams = CSV.read(locations[:game_teams], headers: true, header_converters: :symbol)
    end
end


#CSV.foreach('./data/animal_lovers.csv', headers: true, header_converters: :symbol) do |row| #out one level then in one level select file animal_lovers.csv
# animal_lovers << AnimalLover.new
# (
#     row[:id].to_i, 
#     row[:first_name], 
#     row[:last_name], 
#     row[:age].to_i
#     )
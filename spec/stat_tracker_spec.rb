require 'spec_helper'

RSpec.describe StatTracker do

    describe '#initialize' do

        it 'creates instance variables for games, teams, and game_teams' do
            # I think mocking the output here is necessary based on the size/row count of each .csv file
            # so this is how I did it for now but we can discuss still! I read something about "fixtures" that seem similar
            mock_games = double('games')
            mock_teams = double('teams')
            mock_game_teams = double('game_teams')

            stat_tracker = StatTracker.new(mock_games, mock_teams, mock_game_teams)

            expect(stat_tracker.instance_variable_get(:@games)).to eq(mock_games)
            expect(stat_tracker.instance_variable_get(:@teams)).to eq(mock_teams)
            expect(stat_tracker.instance_variable_get(:@game_teams)).to eq(mock_game_teams)
        end
    end

    describe '#.from_csv' do
            
        it 'returns a StatTracker with loaded game, team, and game_team data' do
          
            locations = {
            games: './data/games.csv',
            teams: './data/teams.csv',
            game_teams: './data/game_teams.csv'
            }
          
          stat_tracker = StatTracker.from_csv(locations)
      
          expect(stat_tracker).to be_a(StatTracker)
          expect(stat_tracker.instance_variable_get(:@games)).to be_a(CSV::Table)
          expect(stat_tracker.instance_variable_get(:@teams)).to be_a(CSV::Table)
          expect(stat_tracker.instance_variable_get(:@game_teams)).to be_a(CSV::Table)
          expect(stat_tracker.instance_variable_get(:@games).first).to be_a(CSV::Row)
        end
      end

      it "can calculate highest sum of the winning and losing teams’ scores" do

      end

      it "can calculate lowest sum of the winning and losing teams’ scores" do

      end

      it "can calculate the percentage of games that a home team has won (rounded to the nearest 100th)" do

      end

      it "can calculate the percentage of games that a visitor has won (rounded to the nearest 100th)" do

      end

      it "can calculate the percentage of games that has resulted in a tie (rounded to the nearest 100th)" do

      end

      it "can store games by season" do

      end

      it "can averae goals per game" do 

      end

      it 'can average goals per game per season' do
        
      end
      
end
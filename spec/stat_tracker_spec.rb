require 'spec_helper'

RSpec.describe StatTracker do

    describe '#initialize' do

        xit 'creates instance variables for games, teams, and game_teams' do
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
            
        xit 'returns a StatTracker with loaded game, team, and game_team data' do
          
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

    describe 'calculate' do
        it "can calculate highest sum of the winning and losing teams’ scores" do
            locations = {
                games: './spec/fixtures/games_fixture.csv',
                teams: './spec/fixtures/teams_fixture.csv',
                game_teams: './spec/fixtures/game_teams_fixture.csv'
            }
        
            stat_tracker = StatTracker.from_csv(locations)
            expect(stat_tracker.highest_total_score).to eq(5) # 2+4 = 6 in Game 3
        
        end

        it "can calculate lowest sum of the winning and losing teams’ scores" do
            locations = {
                games: './spec/fixtures/games_fixture.csv',
                teams: './spec/fixtures/teams_fixture.csv',
                game_teams: './spec/fixtures/game_teams_fixture.csv'
            }

            stat_tracker = StatTracker.from_csv(locations)
            expect(stat_tracker.lowest_total_score).to eq(2) # Adjust based on your fixture data


        end

        it "can calculate the percentage of games that a home team has won (rounded to the nearest 100th)" do
            locations = {
                games: './spec/fixtures/games_fixture.csv',
                teams: './spec/fixtures/teams_fixture.csv',
                game_teams: './spec/fixtures/game_teams_fixture.csv'
              }
            
              stat_tracker = StatTracker.from_csv(locations)
              expect(stat_tracker.percentage_home_wins).to eq(0.67) # Adjust based on your fixture data
            

        end

        it "can calculate the percentage of games that a visitor has won (rounded to the nearest 100th)" do
            stat_tracker = StatTracker.from_csv({
                games: './spec/fixtures/games_fixture.csv',
                teams: './spec/fixtures/teams_fixture.csv',
                game_teams: './spec/fixtures/game_teams_fixture.csv'
              })
            
              expect(stat_tracker.percentage_visitor_wins).to eq(0.0) # Adjust based on fixture
            

        end

        it "can calculate the percentage of games that has resulted in a tie (rounded to the nearest 100th)" do
            stat_tracker = StatTracker.from_csv({
                games: './spec/fixtures/games_fixture.csv',
                teams: './spec/fixtures/teams_fixture.csv',
                game_teams: './spec/fixtures/game_teams_fixture.csv'
              })
            
              expect(stat_tracker.percentage_ties).to eq(0.33) # Update based on fixture data
            

        end

        it "can store games by season" do
            stat_tracker = StatTracker.from_csv({
                games: './spec/fixtures/games_fixture.csv',
                teams: './spec/fixtures/teams_fixture.csv',
                game_teams: './spec/fixtures/game_teams_fixture.csv'
              })
            
              expect(stat_tracker.count_of_games_by_season).to eq({
                "20122013" => 2,
                "20132014" => 1
              }) # Adjust based on your fixtures
            

        end

        it "can averae goals per game" do 
            stat_tracker = StatTracker.from_csv({
                games: './spec/fixtures/games_fixture.csv',
                teams: './spec/fixtures/teams_fixture.csv',
                game_teams: './spec/fixtures/game_teams_fixture.csv'
              })
            
              expect(stat_tracker.average_goals_per_game).to eq(3.67) # Update to match fixture
            

        end

        xit 'can average goals per game per season' do
            stat_tracker = StatTracker.from_csv({
                games: './spec/fixtures/games_fixture.csv',
                teams: './spec/fixtures/teams_fixture.csv',
                game_teams: './spec/fixtures/game_teams_fixture.csv'
              })
            
              expect(stat_tracker.average_goals_by_season).to eq({
                "20122013" => 3.5,
                "20132014" => 4.0
              }) # Adjust based on your fixture
            
        end

    end
    
      
      describe 'spec_harness results' do

        before(:each) do
            
            game_path = './data/games.csv'
            team_path = './data/teams.csv'
            game_teams_path = './data/game_teams.csv'

            locations = {
            games: game_path,
            teams: team_path,
            game_teams: game_teams_path
            }

            @stat_tracker = StatTracker.from_csv(locations)
        end
        
        #Game Statistics

        it "exists" do
            expect(@stat_tracker).to be_an_instance_of StatTracker
        end
        

        it "#highest_total_score" do
            expect(@stat_tracker.highest_total_score).to eq 11
        end
    
        it "#lowest_total_score" do
            expect(@stat_tracker.lowest_total_score).to eq 0
        end
    
        it "#percentage_home_wins" do
            expect(@stat_tracker.percentage_home_wins).to eq 0.44
        end
    
        it "#percentage_visitor_wins" do
            expect(@stat_tracker.percentage_visitor_wins).to eq 0.36
        end
    
        it "#percentage_ties" do
            expect(@stat_tracker.percentage_ties).to eq 0.20
        end
    
        it "#count_of_games_by_season" do
        
            expected = {
                "20122013"=>806,
                "20162017"=>1317,
                "20142015"=>1319,
                "20152016"=>1321,
                "20132014"=>1323,
                "20172018"=>1355
            }

            expect(@stat_tracker.count_of_games_by_season).to eq expected
        end
        
        it "#average_goals_per_game" do
            expect(@stat_tracker.average_goals_per_game).to eq 4.22
        end
    
        it "#average_goals_by_season" do
            expected = {
                "20122013"=>4.12,
                "20162017"=>4.23,
                "20142015"=>4.14,
                "20152016"=>4.16,
                "20132014"=>4.19,
                "20172018"=>4.44
            }
            expect(@stat_tracker.average_goals_by_season).to eq expected
        end
    
        #League Statistics

        it "#count_of_teams" do
            expect(@stat_tracker.count_of_teams).to eq 32
        end

        it "#best_offense" do
            expect(@stat_tracker.best_offense).to eq "Reign FC"
        end

        it "#worst_offense" do
            expect(@stat_tracker.worst_offense).to eq "Utah Royals FC"
        end

        it "#highest_scoring_visitor" do
            expect(@stat_tracker.highest_scoring_visitor).to eq "FC Dallas"
        end

        it "#highest_scoring_home_team" do
            expect(@stat_tracker.highest_scoring_home_team).to eq "Reign FC"
        end

        it "#lowest_scoring_visitor" do
            expect(@stat_tracker.lowest_scoring_visitor).to eq "San Jose Earthquakes"
        end

        it "#lowest_scoring_home_team" do
            expect(@stat_tracker.lowest_scoring_home_team).to eq "Utah Royals FC"
        end

        #Season Statistics

        it "#winningest_coach" do
            expect(@stat_tracker.winningest_coach("20132014")).to eq "Claude Julien"
            expect(@stat_tracker.winningest_coach("20142015")).to eq "Alain Vigneault"
        end

        it "#worst_coach" do
            expect(@stat_tracker.worst_coach("20132014")).to eq "Peter Laviolette"
            expect(@stat_tracker.worst_coach("20142015")).to eq("Craig MacTavish").or(eq("Ted Nolan"))
        end

        it "#most_accurate_team" do
            expect(@stat_tracker.most_accurate_team("20132014")).to eq "Real Salt Lake"
            expect(@stat_tracker.most_accurate_team("20142015")).to eq "Toronto FC"
        end

        it "#least_accurate_team" do
            expect(@stat_tracker.least_accurate_team("20132014")).to eq "New York City FC"
            expect(@stat_tracker.least_accurate_team("20142015")).to eq "Columbus Crew SC"
        end

        it "#most_tackles" do
            expect(@stat_tracker.most_tackles("20132014")).to eq "FC Cincinnati"
            expect(@stat_tracker.most_tackles("20142015")).to eq "Seattle Sounders FC"
        end

        it "#fewest_tackles" do
            expect(@stat_tracker.fewest_tackles("20132014")).to eq "Atlanta United"
            expect(@stat_tracker.fewest_tackles("20142015")).to eq "Orlando City SC"
        end

        #Iteration 4 stuff

        it "#team_info" do
            expected = {
            "team_id" => "18",
            "franchise_id" => "34",
            "team_name" => "Minnesota United FC",
            "abbreviation" => "MIN",
            "link" => "/api/v1/teams/18"
            }

            expect(@stat_tracker.team_info("18")).to eq expected
        end

        it "#best_season" do
            expect(@stat_tracker.best_season("6")).to eq "20132014"
        end

        it "#worst_season" do
            expect(@stat_tracker.worst_season("6")).to eq "20142015"
        end

        it "#average_win_percentage" do
            expect(@stat_tracker.average_win_percentage("6")).to eq 0.49
        end

        it "#most_goals_scored" do
            expect(@stat_tracker.most_goals_scored("18")).to eq 7
        end

        it "#fewest_goals_scored" do
            expect(@stat_tracker.fewest_goals_scored("18")).to eq 0
        end

        it "#favorite_opponent" do
            expect(@stat_tracker.favorite_opponent("18")).to eq "DC United"
        end

        it "#rival" do
            expect(@stat_tracker.rival("18")).to eq("Houston Dash").or(eq("LA Galaxy"))
        end
    end


end
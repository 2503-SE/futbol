require 'spec_helper'

RSpec.describe 'Data Integrity' do

  let(:locations) do
    {
      games: './data/games.csv',
      teams: './data/teams.csv',
      game_teams: './data/game_teams.csv'
    }
  end

  let(:stat_tracker) { StatTracker.from_csv(locations) }

  describe 'Team data' do

    it 'has all important attributes populated' do
      stat_tracker.teams.each do |team|
        expect(team.team_id).to be_a(Integer)
        expect(team.franchise_id).to be_a(Integer)
        expect(team.team_name).to be_a(String)
        expect(team.abbreviation).to be_a(String)
        expect(team.stadium).to be_a(String)
        expect(team.link).to be_a(String)
      end
    end
  end

  describe 'GameTeam data' do

    it 'has all important attributes populated' do
      stat_tracker.game_teams.each do |game_team|
        expect(game_team.game_id).to be_a(Integer)
        expect(game_team.team_id).to be_a(Integer)
        expect(game_team.hoa).to be_a(String)
        expect(game_team.result).to be_a(String)
        expect(game_team.head_coach).to be_a(String)
        expect(game_team.goals).to be_a(Integer)
        expect(game_team.shots).to be_a(Integer)
        expect(game_team.tackles).to be_a(Integer)
      end
    end
  end

  describe 'Game data' do
    
    it 'has all important attributes populated' do
      stat_tracker.games.each do |game|
        expect(game.game_id).to be_a(Integer)
        expect(game.season).to be_a(String)
        expect(game.type).to be_a(String)
        expect(game.date_time).to be_a(String)
        expect(game.away_team_id).to be_a(Integer)
        expect(game.home_team_id).to be_a(Integer)
      end
    end
  end
end
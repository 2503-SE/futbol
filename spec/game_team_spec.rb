require 'spec_helper'
require './lib/game_team'

RSpec.describe GameTeam do

  before(:each) do
  
    @row = {
      :game_id => 2012030221,
      :team_id => 3,
      :hoa => "away",
      :result => "LOSS",
      :settled_in => "OT",
      :head_coach => "John Tortorella",
      :goals => 2,
      :shots => 8,
      :tackles => 44,
      :pim => 8,
      :power_play_opportunities => 3,
      :power_play_goals => 0,
      :face_off_win_percentage => 44.8,
      :giveaways => 17,
      :takeaways => 7
    }

    @game_team = GameTeam.new(@row)
  end
  
  it '#initializes with the correct values' do

    expect(@game_team).to be_an_instance_of(GameTeam)
    
    expect(@game_team.game_id).to eq(2012030221)
    expect(@game_team.team_id).to eq(3)
    expect(@game_team.hoa).to eq("away")
    expect(@game_team.result).to eq("LOSS")
    expect(@game_team.settled_in).to eq("OT")
    expect(@game_team.head_coach).to eq("John Tortorella")
    expect(@game_team.goals).to eq(2)
    expect(@game_team.shots).to eq(8)
    expect(@game_team.tackles).to eq(44)
    expect(@game_team.pim).to eq(8)
    expect(@game_team.power_play_opportunities).to eq(3)
    expect(@game_team.power_play_goals).to eq(0)
    expect(@game_team.face_off_win_percentage).to eq(44.8)
    expect(@game_team.giveaways).to eq(17)
    expect(@game_team.takeaways).to eq(7)
  end

  it 'correctly transforms data types upon instantiation' do

    expect(@game_team.game_id).to be_a(Integer)
    expect(@game_team.team_id).to be_a(Integer)

    expect(@game_team.goals).to be_a(Integer)
    expect(@game_team.shots).to be_a(Integer)
    expect(@game_team.tackles).to be_a(Integer)
    expect(@game_team.pim).to be_a(Integer)
    expect(@game_team.power_play_opportunities).to be_a(Integer)
    expect(@game_team.power_play_goals).to be_a(Integer)
    expect(@game_team.face_off_win_percentage).to be_a(Float)
    expect(@game_team.giveaways).to be_a(Integer)
    expect(@game_team.takeaways).to be_a(Integer)

    expect(@game_team.hoa).to be_a(String)
    expect(@game_team.result).to be_a(String)
    expect(@game_team.settled_in).to be_a(String)
    expect(@game_team.head_coach).to be_a(String)
    expect(@game_team.game_id).to be_a(Integer)
  end
  

end
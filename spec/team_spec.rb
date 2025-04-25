require 'spec_helper'
require './lib/team'

RSpec.describe Team do

  before(:each) do
  
    @row = {
      :team_id => 1,
      :franchiseid => 23,
      :teamname => "Atlanta United",
      :abbreviation => "ATL",
      :stadium => "Mercedes-Benz Stadium",
      :link => "/api/v1/teams/1"
    }

    @team = Team.new(@row)
  end
  
  it 'initializes with the correct values' do

    expect(@team).to be_a(Team)
    
    expect(@team.team_id).to eq(1)
    expect(@team.franchise_id).to eq(23)
    expect(@team.team_name).to eq("Atlanta United")
    expect(@team.abbreviation).to eq("ATL")
    expect(@team.stadium).to eq("Mercedes-Benz Stadium")
    expect(@team.link).to eq("/api/v1/teams/1")
  end

  it 'correctly transforms data types upon instantiation' do

    expect(@team.team_id).to be_a(Integer)
    expect(@team.franchise_id).to be_a(Integer)
    
    expect(@team.team_name).to be_a(String)
    expect(@team.abbreviation).to be_a(String)
    expect(@team.stadium).to be_a(String)
    expect(@team.link).to be_a(String)
  end 


end
require 'simplecov'
SimpleCov.start do
  add_filter "/spec/"
end

require 'pry'
require 'rspec'
require_relative '../lib/stat_tracker'
require_relative './game_spec'
require_relative './team_spec'
require_relative './game_team_spec'
# require_relative './game_factory'
# require_relative './team_factory'
# require_relative './game_team_factory'
require './lib/stat_tracker'
require './lib/game_team'
require './lib/team'


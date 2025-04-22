class GameTeam

  attr_reader :game_id,
              :team_id,
              :hoa,
              :result,
              :settled_in,
              :head_coach,
              :goals,
              :shots,
              :tackles,
              :pim,
              :power_play_opportunities,
              :power_play_goals,
              :face_off_win_percentage,
              :giveaways,
              :takeaways

  def initialize(row)
    @game_id = row[:game_id].to_i
    @team_id = row[:team_id].to_i
    @hoa = row[:hoa]
    @result = row[:result]
    @settled_in = row[:settled_in]
    @head_coach = row[:head_coach]
    @goals = row[:goals].to_i
    @shots = row[:shots].to_i
    @tackles = row[:tackles].to_i
    @pim = row[:pim].to_i
    @power_play_opportunities = row[:power_play_opportunities].to_i
    @power_play_goals = row[:power_play_goals].to_i
    @face_off_win_percentage = row[:face_off_win_percentage].to_f
    @giveaways = row[:giveaways].to_i
    @takeaways = row[:takeaways].to_i
  end



end
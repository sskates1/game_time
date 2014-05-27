require 'csv'
require 'pry'

#reads the movies from the csv file and returns an array
def read_games_csv(csv)
  games = []
  teams = []
  CSV.foreach(csv, headers: true) do |game|
    games << game
    if !(teams.include?(game["home_team"]))
      teams.push(game["home_team"])
    end
    if !(teams.include?(game["away_team"]))
      teams.push(game["away_team"])
    end
  end
  return games,teams
end

def games_for_team(team,season_games)
  games_team = []
  season_games.each do |game|
    new_game={}
    if game["home_team"]==team || game["away_team"]==team
      new_game["home_team"] = game["home_team"]
      new_game["away_team"] = game["away_team"]
      new_game["home_score"] = game["home_score"].to_i
      new_game["away_score"] = game["away_score"].to_i
      games_team.push(new_game)
    end
  end
  games_team
end

def get_record(team,season_games)
  # wins, losses, ties
  record = [0,0,0]
  season_games.each do |game|
    if game["home_team"] == team
      if game["home_score"].to_i > game["away_score"].to_i
        record[0] += 1
      elsif game["home_score"].to_i < game["away_score"].to_i
        record[1] += 1
      else
        record[2] += 1
      end
    end
    if game["away_team"] == team
      if game["home_score"].to_i < game["away_score"].to_i
        record[0] += 1
      elsif game["home_score"].to_i > game["away_score"].to_i
        record[1] += 1
      else
        record[2] += 1
      # end if
      end
    #end if
    end
  #end season_games.each
  end
  record
end

def get_leaderboard(season_games, teams)
  team_records = {}
  leaderboard = []
  teams.each do |team|
    team_records[team] = get_record(team,season_games)
  end
  # insert sort
  team_records.each do |team, record|
    added = false
    leaderboard.each_with_index do |sorted_team, index|
      if record[0]>sorted_team[1][0]
        leaderboard.insert(index, [team,record])
        added = true
        break
      elsif record[0]==sorted_team[1][0] &&record[1]<sorted_team[1][1]
        leaderboard.insert(index, [team,record])
        added = true
        break
      #end if block
      end
    #end leaderboard.each
    end
    # if at this point they are not in the array add them on to the end
    if !(added)
      leaderboard.push([team,record])
    end
  #end team_records.each
  end
  #return leaderboard
  return leaderboard
end


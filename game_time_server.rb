#to run this program/file, rune 'ruby server.rb'
#open webpage name 'localhost:4567'
require_relative "game_time_methods"
require 'sinatra'
require 'json'
require 'pry'

results, teams = read_games_csv("results.csv")
leaderboard = get_leaderboard(results, teams)

get '/' do
  @teams = teams
  @results = results
  erb :index
end

get '/leaderboard' do
  @teams = teams
  @leaderboard = leaderboard
  erb :leaderboard
end

get '/teams/:team' do
  @teams = teams
  @team = params[:team]
  @games_for_team = games_for_team(@team,results)
  @record = get_record(@team, results)
  @results = results
  erb :team
end

post '/' do
  team = params["team"]
  redirect "/teams/#{team}"
end

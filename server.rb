require 'sinatra/base'
require './lib/player'
require './lib/game'

class RockPaperScissors < Sinatra::Base

  configure :production do
    require 'newrelic_rpm'
  end

  get '/' do
    erb :index
  end

  get '/new-game' do
  	erb :new_player
  end

  post '/register' do 
  	@player = params[:name]
  	erb :play	
  end

  post "/play" do
  	player = Player.new(params[:name])
  	player.picks = params[:pick]
  	computer = generate_computer
  	@game = Game.new(player, computer)
  	erb :outcome
  end

  get '/restart-game' do
    erb :play
  end

  def generate_computer
  	choice = ["rock","paper","scissors"].sample

  	comp = Player.new("computer")
  	comp.picks = choice
  	comp
  end



  # start the server if ruby file executed directly
  run! if app_file == $0
end

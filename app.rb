require 'sinatra'
require 'rubygems'
require_relative 'console_random_ai.rb'
require_relative 'console_sequential_ai.rb'
require_relative 'unbeatable_ai.rb'
require_relative 'board.rb'

enable :sessions

ai = ""

get '/' do
board = Board.new 
#session[:board] = Board.new 
	erb :home
end

get '/player_1_name' do
    erb :player_1_name
end

post '/player_1_name' do
	session[:player_1_name] = params[:player_1_name]
	redirect '/opponent_type'
end

get '/opponent_type' do
  erb :opponent_type
end

post '/opponent' do
	player_2 = params[:player_2]

	if player_2 == "human"
		session[:player_2] = Human.new("O")

		erb :player_2_name, :locals => { :board => session[:board].board }

	elsif player_2 == "sequential_ai"
		session[:player_2] = SequentialAi.new("O")
		session[:player_2_name] = "CPU"

		redirect '/play_game'

	elsif player_2 == "random_ai"
		session[:player_2] = RandomAi.new("O")
		session[:player_2_name] = "CPU"

		redirect '/play_game'

	else player_2 == "unbeatable_ai"
		session[:player_2] = UnbeatableAi.new("O")
		session[:player_2_name] = "CPU"

		redirect '/play_game'
	end
end



get '/player_2_name' do
    erb :player_2_name
end

post '/player_2_name' do
    session[:player_2_name] = params[:player_2_name]
	redirect '/play_game'
end


get '/play_game' do
    erb :play_game, :locals => {:board => session[:board].board, :player_1_name => session[:player_1_name], :player_2_name => session[:player_2_name]}
    #the above saves your board and lets you pull it everytime you call it?  Pushes your board into the erb.  This is why mob helps i would have spent hours on that
end

post '/get_player_move' do
    move = params[:square].to_i
    if session[:board].valid_input?(move)
        redirect '/make_move?move=' + move.to_s
    else
        redirect '/play_game'
    end
end

get '/make_move' do
	move_spot = params[:move].to_i

	session[:board].update((move_spot - 1), session[:current_player].marker)

	if session[:board].game_won?(session[:current_player].marker) == true
		player_1 = session[:player_1_name]
		player_2 = session[:player_2_name]
		winner = session[:current_player_name]

		erb :win, :locals => { :current_player => session[:current_player], :current_player_name => session[:current_player_name], :board => session[:board].board }
	elsif session[:board].full_board? == true
		player_1 = session[:player_1_name]
		player_2 = session[:player_2_name]
		winner = "Tie"

		erb :tie, :locals => { :board => session[:board].board }
	else
		if session[:current_player].marker == "X"
			session[:current_player] = session[:player_2]
			session[:current_player_name] = session[:player_2_name]
		else
			session[:current_player] = session[:player_1]
			session[:current_player_name] = session[:player_1_name]
		end

		redirect '/play_game'
	end	
end
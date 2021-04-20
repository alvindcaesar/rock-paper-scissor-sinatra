require 'sinatra'

class HiSinatra < Sinatra::Base

  enable :sessions

  get '/' do
     erb :homepage
  end

  post '/' do
      session['player_name'] = params[:player_name]
      @player_name = session['player_name']
      erb :menu
  end

  get '/play' do
    session['count'] = 0
    erb :play
  end

  get '/play/throw/:player_choice' do
    options = %w(rock paper scissor)
    machine_choice = rand(options.length)
    player_choice = params[:player_choice]

    @machine_answer = options[machine_choice]
    session['count'] = +1

    if player_choice == 'rock' && @machine_answer == 'scissor'
      #player wins
      @result = 'You win!'
    elsif player_choice == 'paper' && @machine_answer == 'rock'
      #player wins
      @result = 'You win!'
    elsif player_choice == 'scissor' && @machine_answer == 'paper'
      #player wins
      @result = 'You win!'
    elsif @machine_answer == 'rock' && player_choice == 'scissor'
      #machine wins
      @result = 'You lose!'
    elsif @machine_answer == 'paper' && player_choice == 'rock'
      #machine wins
      @result = 'You lose!'
    elsif @machine_answer == 'scissor' && player_choice == 'paper'
      #machine wins
      @result = 'You lose!'
    else
      #ties
      @result = 'Tie!'
    end

    erb :play
  end

end

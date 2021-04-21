require 'sinatra'

class RockPaperScissor < Sinatra::Base

  enable :sessions

  get '/' do
     erb :homepage
  end

  post '/menu' do
      session['player_name'] = params[:player_name]
      @player_name = session['player_name'].capitalize!

      erb :menu
  end

  post '/play' do
    session['rounds'] = params["rounds"]
    @rounds = session['rounds'].to_i
    erb :play
  end

  get '/play' do
    session['count'] = 0
    session['count'] += 1
    @rounds = session['rounds'].to_i
    erb :play
  end

  get '/play/throw/:player_choice' do

    options = %w(rock paper scissor)
    machine_choice = rand(options.length)
    player_choice = params[:player_choice]

    @machine_answer = options[machine_choice]

    # session['count'] += 1
    @count = session['count']
    @rounds = session['rounds'].to_i


    if player_choice == 'rock' && @machine_answer == 'scissor'
      #player wins
      @result = 'You win!'
      # store_results('win')
    elsif player_choice == 'paper' && @machine_answer == 'rock'
      #player wins
      @result = 'You win!'
      # store_results('win')
    elsif player_choice == 'scissor' && @machine_answer == 'paper'
      #player wins
      @result = 'You win!'
      # store_results('win')
    elsif @machine_answer == 'rock' && player_choice == 'scissor'
      #machine wins
      @result = 'You lose!'
      # store_results('lose')
    elsif @machine_answer == 'paper' && player_choice == 'rock'
      #machine wins
      @result = 'You lose!'
      # store_results('lose')
    elsif @machine_answer == 'scissor' && player_choice == 'paper'
      #machine wins
      @result = 'You lose!'
      # store_results('lose')
    else
      #ties
      @result = 'Tie!'
      # store_results('ties')
    end

    # session['count'] += 1

    erb :play
  end

  get '/results' do
      session['final_results'] = []
      @final_results = session['final_results']
      @win_results = session['final_results'].count('win')
      @lose_results = session['final_results'].count('lose')
      @ties_results = session['final_results'].count('ties')

    erb :results
  end


  # def store_results(final_results)
  #
  #   # case final_results
  #   # when 'win'
  #   #   session['final_results'].push('win')
  #   # when 'lose'
  #   #   session['final_results'].push('lose')
  #   # when 'ties'
  #   #   session['final_results'].push('ties')
  # end

  def store_multiple_results (name, results)
    session['leaderboard'] = Hash.new
    session['leaderboard'].store(name, results)
  end
end

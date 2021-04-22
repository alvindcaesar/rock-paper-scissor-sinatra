require 'sinatra'

class RockPaperScissors < Sinatra::Base

  enable :sessions

  get '/' do
    erb :homepage
  end

  post '/' do
    session['player_name'] = params[:player_name].capitalize!
    @player_name = session['player_name']
    erb :rounds
  end

  get '/menu' do
    erb :menu
  end

  post '/rounds' do
    @player_name = session['player_name']
    session['rounds'] = params[:rounds]
    @rounds = params['rounds']
    erb :menu
  end

  get '/rounds' do
    erb :rounds
  end

  get '/game' do
    session['results'] = []
    @count = session['rounds']
    session['count'] = session['rounds'].to_i
    erb :game
  end

  get '/game/throw/:player_choice' do

    options = ['Rock','Paper','Scissors']
    computer_choice = rand(options.length)
    player_choice = params[:player_choice]
    @computer_answer = options[computer_choice]
    session['count'] -= 1

    @count = session['count']
    @rounds = session['rounds'].to_i

    if player_choice == 'Rock' && @computer_answer == 'Scissors'
      @result = 'Awesome, you win!'
      store_results('win')
    elsif player_choice == 'Paper' && @computer_answer == 'Rock'
      @result = 'Awesome, you win!'
      store_results('win')
    elsif player_choice == 'Scissors' && @computer_answer == 'Paper'
      @result = 'Awesome, you win!'
      store_results('win')
    elsif @computer_answer == 'Rock' && player_choice == 'Scissors'
      @result = 'Sorry mate, you lose!'
      store_results('lose')
    elsif @computer_answer == 'Paper' && player_choice == 'Rock'
      @result = 'Sorry mate, you lose!'
      store_results('lose')
    elsif @computer_answer == 'Scissors' && player_choice == 'Paper'
      @result = 'Sorry mate, you lose!'
      store_results('lose')
    else
      @result = 'Ok cool, it is tie!'
      store_results('ties')
    end
      erb :game
  end

  get '/results' do
    @player_name = session['player_name']
      @results = session['results']
      @win_results = session['results'].count('win')
      @lose_results = session['results'].count('lose')
      @ties_results = session['results'].count('ties')

      erb :results
    end


  def store_results(results)

    case results
    when 'win'
      session['results'].push('win')
    when 'lose'
      session['results'].push('lose')
    when 'ties'
      session['results'].push('ties')
  end
end
end

require 'sinatra'

class HiSinatra < Sinatra::Base
  get '/' do
     erb :homepage
  end
end

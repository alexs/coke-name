require 'rubygems'
require 'sinatra'
require 'mini_magick'
set :server, 'thin'

get '/' do
  erb :index
end

post '/bottle/create' do 
  @bottle_name = params[:name]

  img = MiniMagick::Image.open("public/vendor/images/bottle.png")

  if @bottle_name.size > 10
    @bottle_name = "No me jodas"
  end

  img.combine_options do |c|
      c.gravity 'Center'
      c.fill 'white'
      c.pointsize '40'
      c.draw "text -30,-20 '#{@bottle_name}'"
    end
  img.write("public/tmp/#{@bottle_name}.png")
  @error = 'Sí realmente te llamas así de largo y feo, deberia estar en un bote de aceite.'

  erb :show
end

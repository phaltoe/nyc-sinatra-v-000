class FiguresController < ApplicationController

  get '/figures' do
    @figures = Figure.all

    erb :"/figures/index"
  end

  get '/figures/new' do
    @landmarks = Landmark.all
    @titles = Title.all

    erb :"/figures/new"
  end

  post '/figures' do 
    @figure = Figure.create(params[:figure])
    @figure.titles << Title.find_or_create_by(params[:title])
    @figure.landmarks << Landmark.find_or_create_by(params[:landmark])

    redirect "/figures/#{@figure.id}"
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])

    erb :"/figures/show"
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    @landmarks = Landmark.all
    @titles = Title.all

    erb :"/figures/edit"
  end

  patch '/figures/:id' do
    @figure = Figure.find(params[:id])
    @figure.update(:name => params[:figure][:name])
    @figure.titles << Title.create(params[:title][:name]) if params[:title][:name].present?
    @figure.landmarks << Landmark.create(params[:landmark]) if params[:landmark][:name].present?
    @figure.save

    redirect "/figures/#{@figure.id}"
  end
end
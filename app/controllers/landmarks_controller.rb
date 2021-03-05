class LandmarksController < ApplicationController
  # add controller methods
  
  get "/landmarks/new" do
    @figures = Figure.all
    erb :"/landmarks/new"
  end

  post "/landmarks" do
    @landmark = Landmark.create(params[:landmark])
    if !params["figure"]["name"].empty?
      @landmark.create_figure(name: params["figure"]["name"])
      @landmark.save
    end
    redirect "/landmarks/#{@landmark.id}"
  end

  get "/landmarks" do
    @landmarks = Landmark.all
    erb :"/landmarks/index"
  end

  get "/landmarks/:id" do
    @landmark = Landmark.find_by("id", params[:id])
    erb :"/landmarks/show"
  end

  get "/landmarks/:id/edit" do
    @landmark = Landmark.find_by("id", params[:id])
    erb :"/landmarks/edit"
  end

  patch "/landmarks/:id" do
    @landmark = Landmark.find_by("id", params[:id])
    # @landmark.update(name: params["name"], year_completed: params["year_completed"])
    @landmark.update(params["landmark"])
    redirect "/landmarks/#{@landmark.id}"
  end
end

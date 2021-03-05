class FiguresController < ApplicationController
  # add controller methods

  get "/figures" do
    @figures = Figure.all
    erb :"/figures/index"
  end

  get "/figures/new" do
    @titles = Title.all
    @landmarks = Landmark.all
    erb :"/figures/new"
  end

  post "/figures" do
    # binding.pry
    @figure = Figure.create(params[:figure])
    
    if !params["title"]["name"].empty?
      @figure.titles << Title.create(name: params["title"]["name"])
    end

    if !params["landmark"]["name"].empty?
      @figure.landmarks << Landmark.create(name: params["landmark"]["name"])
    end
    # binding.pry
    redirect "/figures/#{@figure.id}"
  end

  get "/figures/:id" do
    @figure = Figure.find_by("id", params["id"])
    erb :"/figures/show"
  end

  get "/figures/:id/edit" do
    @figure = Figure.find_by("id", params["id"])
    @titles = Title.all
    @landmarks = Landmark.all
    erb :"/figures/edit"
  end

  patch "/figures/:id" do
    if !params[:figure].keys.include?("title_ids")
      params[:figure]["title_ids"] = []
    end

    if !params[:figure].keys.include?("landmark_ids")
      params[:figure]["landmark_ids"] = []
    end

    @figure = Figure.find_by("id", params[:id])
    @figure.update(params["figure"])
    if !params["title"]["name"].empty?
      @figure << Title.create(name: params["title"]["name"])
    end
    if !params["landmark"]["name"].empty?
      @figure << Landmark.create(name: params["landmark"]["name"])
    end
    redirect "/figures/#{@figure.id}"
  end
end

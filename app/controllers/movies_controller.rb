class MoviesController < ApplicationController
  def new
    @movie = Movie.new
  end

  def index
    @movies = Movie.order( :created_at => :desc )
    respond_to do |format|
      format.json do
        render json: @movies
      end

      format.html
    end
  end

  def show
    @movie = Movie.find(params.fetch(:id))
  end

  def create
    movie_attributes = params.require(:movie).permit(:title, :description)
    @movie = Movie.new(movie_attributes)


    if @movie.valid?
      @movie.save
      redirect_to movies_url, :notice => "Movie created successfully."
    else
      render template: "movies/new"
    end
  end

  def edit
    @movie = Movie.where({ :id => params.fetch(:id) }).first

  end

  def update
    @movie = Movie.where({ :id => params.fetch(:id)})[0]

    movie_attributes = params.require(:movie).permit(:title, :description)
    @movie = Movie.new(movie_attributes)

    if @movie.valid?
      @movie.save
      redirect_to movie_url(@movie), :notice => "Movie updated successfully."
    else
      redirect_to movie_url(@movie), :alert => "Movie failed to update successfully."
    end
  end

  def destroy
    the_id = params.fetch(:id)
    the_movie = Movie.where({ :id => the_id }).first

    the_movie.destroy

    redirect_to movies_url, :notice => "Movie deleted successfully."
  end
end

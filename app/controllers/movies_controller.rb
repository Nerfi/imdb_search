class MoviesController < ApplicationController
#con este codigo  encontraremos movies by title
 #de But super wont return Superman Returns
  def index
    if params[:query].present?
      @movies = Movie.where(title: params[:query])
    else
    @movies = Movie.all

    end
  end
end


#Where ILIKE
#We want super to return movies with Superman in its title:


class MoviesController < ApplicationController
  def index
    if params[:query].present?
      @movies = Movie.where("title ILIKE ?", "%#{params[:query]}%") # esa condicion la conseguimos con esta linea
    else
      @movies = Movie.all
    end
  end
end

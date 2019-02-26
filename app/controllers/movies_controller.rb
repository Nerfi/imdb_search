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


#Searching multiple columns - Or
#The term might be in the movie's title or in its syllabus...


class MoviesController < ApplicationController
  def index
    if params[:query].present?
      sql_query = "title ILIKE :query OR syllabus ILIKE :query"
      @movies = Movie.where(sql_query, query: "%#{params[:query]}%")
    else
      @movies = Movie.all
    end
  end
end

#Searching through association - Joins
#The term might also be in the director's name:

class MoviesController < ApplicationController
  def index
    if params[:query].present?
      sql_query = " \
        movies.title ILIKE :query \
        OR movies.syllabus ILIKE :query \
        OR directors.first_name ILIKE :query \
        OR directors.last_name ILIKE :query \
      "
      @movies = Movie.joins(:director).where(sql_query, query: "%#{params[:query]}%")
    else
      @movies = Movie.all
    end
  end
end



#Searching multiple terms - @@
#If a user looks for superman batman, ILIKE won't return anyt

class MoviesController < ApplicationController
  def index
    if params[:query].present?
      sql_query = " \
        movies.title @@ :query \
        OR movies.syllabus @@ :query \
        OR directors.first_name @@ :query \
        OR directors.last_name @@ :query \
      "
      @movies = Movie.joins(:director).where(sql_query, query: "%#{params[:query]}%")
    else
      @movies = Movie.all
    end
  end
end

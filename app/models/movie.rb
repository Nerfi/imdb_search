class Movie < ApplicationRecord
  belongs_to :director

  def index
    @movies = Movie.all

  end
end

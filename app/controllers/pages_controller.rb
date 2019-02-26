class PagesController < ApplicationController
  def home

  end

  def index
    @movies = Movie.all

  end
end

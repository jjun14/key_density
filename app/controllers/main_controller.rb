class MainController < ApplicationController
  def index
  end

  def create
    crawler = Crawler.new
    @keywords = crawler.obtain(params[:url], 10)
    render json: @keywords
  end
end

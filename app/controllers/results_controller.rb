class ResultsController < ApplicationController

  def index
    spyder_id = params[:spyder_id]
    res = HTTParty.get "http://139.162.101.250/api/spyder_videos/videos?spyder_id=#{spyder_id}"
    
  end

  def show
    respond_to do |format|
      format.html
    end
  end

end

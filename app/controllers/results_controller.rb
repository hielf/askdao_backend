class ResultsController < ApplicationController
  protect_from_forgery with: :null_session

  def videos
    spyder_id = params[:spyder_id]
    res = HTTParty.get "http://139.162.101.250/api/spyder_videos/videos?spyder_id=#{spyder_id}"
    @data = JSON.parse(res.body)["data"]["videos"]
    @keyword = JSON.parse(res.body)["data"]["keyword"]

    respond_to do |format|
      format.html
    end
  end

  def articles
    spyder_id = params[:spyder_id]
    res = HTTParty.get "http://139.162.101.250/api/spyder_articles/articles?spyder_id=#{spyder_id}"
    @data = JSON.parse(res.body)["data"]["articles"]
    @keyword = JSON.parse(res.body)["data"]["keyword"]

    respond_to do |format|
      format.html
    end
  end

  def my_videos
    user = User.find_by(open_id: params[:user])
    @videos = user.videos.order(created_at: :desc)

    respond_to do |format|
      format.html
    end
  end

  def show
    respond_to do |format|
      format.html
    end
  end

  def submit_download
    ids = params[:ids].map{|i| i.to_i}
    if (ids && !ids.empty?)
      message = Message.last
      message.delay(:queue => 'sending').video_download(ids)

      render_json(0, '提交成功')
    else
      render_json(1, '提交失败')
    end
  end

end

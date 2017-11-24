class ResultsController < ApplicationController

  def videos
    spyder_id = params[:spyder_id]
    res = HTTParty.get "http://139.162.101.250/api/spyder_videos/videos?spyder_id=#{spyder_id}"
    @data = JSON.parse(res.body)["data"]["videos"]

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
    ids = params(:ids)
    massage = Message.last
    message.delay(:queue => 'sending').video_download(ids)

    render_json(0, '提交成功')
  end

end

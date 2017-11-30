class VideosController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    requires! :name, type: String
    requires! :video_src, type: String
    requires! :video_cover, type: String
    requires! :status, type: Integer, values: %w(0 1)
    requires! :secret, type: String

    return render_json(1, '上传失败') if (params[:secret] != (Digest::MD5.hexdigest (params[:name] + 1.to_s)))

    video = Video.create(user_id: current_user.id,
                         name: params[:name],
                         video_src: params[:video_src],
                         video_cover: params[:video_cover],
                         status: params[:status])
    if video.save
      render_json(0, '上传成功')
    else
      render_json(1, '上传失败')
    end
  end

end

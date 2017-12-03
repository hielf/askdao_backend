class VideosController < ApplicationController
  # skip_before_filter :verify_authenticity_token
  protect_from_forgery with: :null_session, if: Proc.new {|c| c.request.format.json? }

  def create
    requires! :name, type: String
    requires! :video_src, type: String
    requires! :video_cover, type: String
    requires! :author, type: String
    requires! :status, type: Integer, values: %w(0 1)
    requires! :secret, type: String
    requires! :user, type: String

    return render_json(1, '上传失败') if (params[:secret] != (Digest::MD5.hexdigest (params[:name] + 1.to_s)))

    return render_json(1, '文件已存在') if Video.find_by(user_id: User.find_by(open_id: params[:user]).id, video_src: params[:video_src])

    video = Video.create(user_id: User.find_by(open_id: params[:user]).id,
                         name: params[:name],
                         video_src: params[:video_src],
                         video_cover: params[:video_cover],
                         author: params[:author],
                         status: params[:status])
    if video.save
      render_json(0, '上传成功')
    else
      render_json(1, '上传失败')
    end
  end

  def remove
    video = Video.find_by(id: params[:video_id])

    if video.destroy
      render_json(0, '删除成功')
    else
      render_json(1, '删除失败')
    end
  end

end

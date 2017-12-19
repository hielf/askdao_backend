class ArticlesController < ApplicationController
  # skip_before_filter :verify_authenticity_token
  protect_from_forgery with: :null_session, if: Proc.new {|c| c.request.format.json? }

  def create
    requires! :title, type: String
    requires! :author, type: String
    requires! :url, type: String
    requires! :status, type: Integer, values: %w(0 1)
    requires! :secret, type: String
    requires! :user, type: String

    return render_json(1, '上传失败') if (params[:secret] != (Digest::MD5.hexdigest (params[:title] + 1.to_s)))

    return render_json(1, '文件已存在') if Article.find_by(user_id: User.find_by(open_id: params[:user]).id, url: params[:url])

    article = Article.create(user_id: User.find_by(open_id: params[:user]).id,
                             title: params[:title],
                             summary: params[:summary],
                             author: params[:author],
                             url: params[:url],
                             status: params[:status])
    if article.save
      render_json(0, '上传成功')
    else
      render_json(1, '上传失败')
    end
  end

  def remove
    article = Article.find_by(id: params[:article_id])
    if article.destroy
      render_json(0, '删除成功')
    else
      render_json(1, '删除失败')
    end
  end

end

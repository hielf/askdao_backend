class WechatReportsController < ApplicationController
  wechat_api
  layout 'wechat'
  protect_from_forgery with: :null_session, if: Proc.new {|c| c.request.format.json? }
  # def index
  #   @lots = Lot.with_preloading.wip_lot
  # end

  def search_result
    # openid = "og7qVxKXBQqtPAePsFSQGXqHWETk"
    openid = params[:open_id]
    key_word = params[:key_word]
    count = params[:count]
    spyder_id = params[:spyder_id]

    url = "http://wendao.easybird.cn/results/videos?spyder_id=#{spyder_id}"

    template = YAML.load(File.read('app/views/templates/result.yml'))
    template['template']['url'].gsub!("*url", "#{url}")
    template['template']['data']['first']['value'].gsub!("*first", "您好,已为您搜索到以下结果")
    template['template']['data']['keyword1']['value'].gsub!("*keyword1", "#{key_word}")
    template['template']['data']['keyword2']['value'].gsub!("*keyword2", "一共有#{count}条结果")
    template['template']['data']['keyword3']['value'].gsub!("*keyword3", "YOUTUBE")
    template['template']['data']['keyword4']['value'].gsub!("*keyword4", "1")
    template['template']['data']['keyword5']['value'].gsub!("*keyword5", "#{Date.today}")

    wechat.template_message_send Wechat::Message.to(openid).template(template['template'])

    render_json(0, 'SUCCESS')
  end

  def scholar_result
    # openid = "og7qVxKXBQqtPAePsFSQGXqHWETk"
    openid = params[:open_id]
    key_word = params[:key_word]
    count = params[:count]
    spyder_id = params[:spyder_id]

    url = "http://wendao.easybird.cn/results/articles?spyder_id=#{spyder_id}"

    template = YAML.load(File.read('app/views/templates/result.yml'))
    template['template']['url'].gsub!("*url", "#{url}")
    template['template']['data']['first']['value'].gsub!("*first", "您好,已为您搜索到以下结果")
    template['template']['data']['keyword1']['value'].gsub!("*keyword1", "#{key_word}")
    template['template']['data']['keyword2']['value'].gsub!("*keyword2", "一共有#{count}篇文章")
    template['template']['data']['keyword3']['value'].gsub!("*keyword3", "GOOGLE学术")
    template['template']['data']['keyword4']['value'].gsub!("*keyword4", "1")
    template['template']['data']['keyword5']['value'].gsub!("*keyword5", "#{Date.today}")

    wechat.template_message_send Wechat::Message.to(openid).template(template['template'])

    render_json(0, 'SUCCESS')
  end

end

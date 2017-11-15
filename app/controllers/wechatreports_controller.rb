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

    template = YAML.load(File.read('app/views/templates/result.yml'))
    template['template']['url'].gsub!("*url", "#{openid}")
    template['template']['data']['first']['value'].gsub!("*first", "您好,已为您搜索到以下结果")
    template['template']['data']['keyword1']['value'].gsub!("*keyword1", "#{key_word}")
    template['template']['data']['keyword2']['value'].gsub!("*keyword2", "一共有#{count}条结果")
    template['template']['data']['keyword3']['value'].gsub!("*keyword3", "")
    template['template']['data']['keyword4']['value'].gsub!("*keyword4", "")
    template['template']['data']['keyword5']['value'].gsub!("*keyword5", "")

    wechat.template_message_send Wechat::Message.to(openid).template(template['template'])

    render_json(0, 'SUCCESS')
  end

end

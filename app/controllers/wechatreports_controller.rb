class WechatReportsController < ApplicationController
  wechat_api
  layout 'wechat'
  protect_from_forgery with: :null_session, if: Proc.new {|c| c.request.format.json? }
  # def index
  #   @lots = Lot.with_preloading.wip_lot
  # end

  def search_result
    openid = params[:open_id]
    template = YAML.load(File.read('app/views/templates/result.yml'))
    wechat.template_message_send Wechat::Message.to(openid).template(template['template'])
  end

end

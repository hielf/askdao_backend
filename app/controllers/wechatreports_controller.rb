class WechatReportsController < ApplicationController
  wechat_api
  layout 'wechat'
  skip_before_filter :verify_authenticity_token, if: :json_request?
  # def index
  #   @lots = Lot.with_preloading.wip_lot
  # end

  def search_result
    openid = params[:open_id]
    template = YAML.load(File.read('app/views/templates/result.yml'))
    wechat.template_message_send Wechat::Message.to(openid).template(template['template'])
  end
  
end

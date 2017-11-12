module Api
  module V1
    class MessagesController < Api::V1::ApplicationController

      def get_message
        user = User.find_or_create_by(open_id: params[:openid])
        message = Message.create(user_id: user.id, content: params[:content])

        if message.save
          render_json(0, '创建成功')
        else
          render_json(1)
        end
      end

    end
  end
end

# module Api
#   module V1
#     class ApplicationController < ActionController::API
#       include ActionController::Caching
#       include ::ActionController::Cookies
#       include ::ActionController::Flash
#       include ActionView::Helpers::OutputSafetyHelper
#       include ApplicationHelper
#       include ActionView::Helpers::TranslationHelper
#       class ParameterValueNotAllowed < ActionController::ParameterMissing
#         attr_reader :values
#
#         def initialize(param, values)
#           @param = param
#           @values = values
#           super("param: #{param} value only allowed in: #{values}")
#         end
#       end
#
#       class AccessDenied < StandardError;
#       end
#       class PageNotFound < StandardError;
#       end
#
#       rescue_from(ActionController::ParameterMissing) do |err|
#         render json: {code: 400, message: "ParameterInvalid: #{err}"}, status: 400
#       end
#       rescue_from(ActiveRecord::RecordInvalid) do |err|
#         render json: {code: 400, message: 'RecordInvalid'}, status: 400
#       end
#       rescue_from(AccessDenied) do |err|
#         render json: {code: 403, message: 'AccessDenied'}, status: 403
#       end
#       rescue_from(ActiveRecord::RecordNotFound) do
#         render json: {code: 404, message: 'Request data not found'}, status: 404
#       end
#
#
#       def requires!(name, opts = {})
#         opts[:require] = true
#         optional!(name, opts)
#       end
#
#       def optional!(name, opts = {})
#         if params[name].blank? && opts[:require] == true
#           raise ActionController::ParameterMissing.new(name)
#         end
#
#         if opts[:values] && params[name].present?
#           values = opts[:values].to_a
#           if !values.include?(params[name]) && !values.include?(params[name].to_i)
#             raise ParameterValueNotAllowed.new(name, opts[:values])
#           end
#         end
#
#         if params[name].blank? && opts[:default].present?
#           params[name] = opts[:default]
#         end
#       end
#
#       def render_json(code, message)
#         render json: {code: code, message: message}
#       end
#
#       def first_error(obj)
#         if obj
#           obj.errors.full_messages[0]
#         end
#       end
#
#       def error_404!
#         render_json(404, 'Page not found')
#       end
#
#       def current_user
#         @current_user ||= User.find_by(access_token: request.headers["token"]) if request.headers["token"]
#       end
#
#       def authenticate!
#         render_json(401, '401 Unauthorized') unless current_user
#       end
#
#       def authenticate_user!
#
#         logger.info request.headers["AppVersion"]
#         token = request.headers["token"]
#         return render_json(401, t("messages.c_401")) if token.blank?
#         user = User.find_by(access_token: token) rescue nil
#         if user
#           @current_user = user
#         else
#           render_json(401, t("messages.c_401"))
#         end
#       end
#
#       def current_ability
#         @current_ability ||= Ability.new(current_user)
#       end
#
#       def can?(*args)
#         current_ability.can?(*args)
#       end
#
#     end
#   end
# end

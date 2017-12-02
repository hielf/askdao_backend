class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include ApplicationHelper

  def render_json(code, message)
    render json: {code: code, message: message}
  end

  def error_404!
    render_json(404, 'Page not found')
  end

  def requires!(name, opts = {})
    opts[:require] = true
    optional!(name, opts)
  end

  def optional!(name, opts = {})
    if params[name].blank? && opts[:require] == true
      raise ActionController::ParameterMissing.new(name)
    end

    if opts[:values] && params[name].present?
      values = opts[:values].to_a
      if !values.include?(params[name]) && !values.include?(params[name].to_i)
        raise ParameterValueNotAllowed.new(name, opts[:values])
      end
    end

    if params[name].blank? && opts[:default].present?
      params[name] = opts[:default]
    end
  end
end

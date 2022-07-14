# frozen_string_literal: true

module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      json_response({ message: e.message }, :not_found)
    end

    # rescue_from ActiveRecord::RecordInvalid do |e|
    #   json_response({ message: e.message }, 400)
    # end

    # rescue_from ActionController::ParameterMissing do |e|
    #   json_response({ message: e.message }, 400)
    # end
  end
end

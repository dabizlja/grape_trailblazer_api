module V1
  module Default
    extend ActiveSupport::Concern

    included do 
      version 'v1', using: :path
      format :json
      prefix :api

      rescue_from ActiveRecord::RecordNotFound do |e|
        error_response(message: e.message, status: 404)
      end

      rescue_from ActiveRecord::RecordInvalid do |e|
        error_response(message: e.message, status: 422)
      end

    end
  end
end
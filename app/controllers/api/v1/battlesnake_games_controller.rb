module API
  module V1
    class BattlesnakeGamesController < ApplicationController
      skip_before_action :verify_authenticity_token

      def ping
        render status: 200, json: "pong"
      end

    end
  end
end
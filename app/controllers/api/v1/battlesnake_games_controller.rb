module API
  module V1
    class BattlesnakeGamesController < ApplicationController
      skip_before_action :verify_authenticity_token

      def ping
        render status: 200, json: {}
      end

      def start
        appearance = {
          color: "#77BCBD",
          head_type: "fang",
          tail_type: "hook"
        }

        render status: 200, json: appearance
      end

      def move
        possible_moves = ["up", "down", "left", "right"]
        movement = { move: possible_moves.sample }

        render status: 200, json: movement
      end

      def end
        render status: 200, json: {}
      end

      private

      def game_params
        params.require(:battlesnake_game).permit(
          :turn,
          game: [
            :id
          ],
          board: [
            :height,
            :width,
            food: [
              :x,
              :y
            ],
            snakes: [
              :id,
              :name,
              :health,
              :shout,
              body: [
                :x,
                :y
              ]
            ]
          ],
          you: [
            :id,
            :name,
            :health,
            :shout,
            body: [
              :x,
              :y
            ]
          ]
        )
      end

    end
  end
end
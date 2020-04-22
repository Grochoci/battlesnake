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
          headType: "fang",
          tailType: "hook"
        }

        render status: 200, json: appearance
      end

      def move
        head = game_params[:you][:body].first
        body = game_params[:you][:body][1..-1]

        possible_moves = ["up", "right", "down", "left"]

        # Simply check for borders and self if ok
        if (head[:y] - 1 < 0) || (body.include?({x: head[:x], y: head[:y] - 1}))
          possible_moves.delete("up")
        end
        if (head[:x] - 1 < 0) || (body.include?({x: head[:x] - 1, y: head[:y]}))
          possible_moves.delete("left")
        end
        if (head[:y] + 1 > game_params[:board][:height]) || (body.include?({x: head[:x], y: head[:y] + 1}))
          possible_moves.delete("down")
        end
        if (head[:x] + 1 > game_params[:board][:width]) || (body.include?({x: head[:x] + 1, y: head[:y]}))
          possible_moves.delete("right")
        end

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
          game: [:id],
          board: [
            :height,
            :width,
            food: [ :x, :y ],
            snakes: [
              :id,
              :name,
              :health,
              :shout,
              body: [ :x, :y ]
            ]
          ],
          you: [
            :id,
            :name,
            :health,
            :shout,
            body: [ :x, :y ]
          ]
        )
      end

    end
  end
end
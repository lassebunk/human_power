module HumanPower
  module Rails
    class RobotsController < ::ApplicationController
      def robots
        text = HumanPower::File.new(self) do
          file = Rails.root.join("config", "robots.rb").to_s
          instance_eval open(file).read, file
        end

        render text: text
      end
    end
  end
end
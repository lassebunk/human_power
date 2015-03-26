require "action_controller"

module HumanPower
  module Rails
    class RobotsController < ActionController::Base
      def robots
        generator = HumanPower::Generator.new(self) do
          file = ::Rails.root.join("config", "robots.rb").to_s
          instance_eval open(file).read, file
        end

        # render text: something does not give correct content type
        render text: generator.render, content_type: Mime::TEXT
      end
    end
  end
end

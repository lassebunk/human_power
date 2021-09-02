module HumanPower
  module Rails
    class RobotsController < ::ApplicationController
      def robots
        generator = HumanPower::Generator.new(self) do
          file = ::Rails.root.join("config", "robots.rb").to_s
          instance_eval open(file).read, file
        end

        # render text: something does not give correct content type
        render text: generator.render, content_type: Mime[:text]
      end
    end
  end
end

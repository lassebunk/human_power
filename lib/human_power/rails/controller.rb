module HumanPower
  module Rails
    class RobotsController < ::ApplicationController
      def robots
        generator = HumanPower::Generator.new(self) do
          file = ::Rails.root.join("config", "robots.rb").to_s
          instance_eval open(file).read, file
        end

        # render text: something does not give correct content type
        response.headers["Content-Type"] = 'text/plain'
        render text: generator.render
      end
    end
  end
end

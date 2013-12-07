require "human_power/version"
require "human_power/configuration"
require "human_power/rails" if defined?(Rails)

module HumanPower
  class << self
    # Yields a configuration block.
    # 
    #   HumanPower.configure do |config|
    #     config.base_controller = MyOtherController
    #   end
    def configure(&block)
      yield self
    end

    # Registers a user agent.
    def register_user_agent(key, name, user_agent_string)

    end

    def user_agents
      @user_agents ||= DEFAULT_USER_AGENTS
    end
  end
end
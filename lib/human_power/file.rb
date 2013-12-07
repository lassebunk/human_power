module HumanPower
  class File
    def initialize(context = nil, &block)
      @context = context
      yield if block_given?
      @current_agent_string = "*"
    end

    def user_agent(key_or_string, &block)
      old_agent_string = @current_agent_string
      
      [key_or_string].flatten.each do |agent|      
        @current_agent_string = case agent
        when String then agent
        when Symbol then HumanPower.user_agents.fetch(agent)
        else raise ArgumentError, "Please supply a string or symbol to `user_agent`."
        end

        instance_eval &block
      end

      @current_agent_string = old_agent_string
    end

    def disallow(*paths)
      rules[@current_agent_string] << paths.map { |path| path == :all ? "*" : path.to_s }
    end

    def disallow_tree(*paths)
      disallow *paths.map { |path| path.end_with?("/") ? path : "#{path}/" }
    end

    def rules
      @rules ||= Hash.new([])
    end

    def method_missing(method, *args, &block)
      if block && HumanPower.user_agents.has_key?(method)
        user_agent method, &block
      else
        context.send method, *args, &block
      end
    end
  end
end
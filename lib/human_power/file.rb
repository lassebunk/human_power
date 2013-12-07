module HumanPower
  class File
    DISALLOW_KEYS = { all: "*", none: "" }

    def initialize(context = nil, &block)
      @context = context
      @current_agent_string = "*"
      instance_eval &block if block
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
      rules[@current_agent_string].push *paths.map { |path| path.is_a?(Symbol) ? DISALLOW_KEYS.fetch(path) : path.to_s }
    end

    def disallow_tree(*paths)
      disallow *paths.map { |path| path.end_with?("/") ? path : "#{path}/" }
    end

    def rules
      @rules ||= Hash.new { |h, k| h[k] = [] }
    end

    def context
      @context
    end

    def to_s
      rules.keys.sort.map do |agent|
        "User-agent: #{agent}\n" +
        rules[agent].uniq.map { |path| "Disallow: #{path}" }.join("\n")
      end.compact.join("\n\n")
    end

    def method_missing(method, *args, &block)
      if block && HumanPower.user_agents.has_key?(method)
        user_agent method, &block
      elsif context
        context.send method, *args, &block
      else
        super
      end
    end
  end
end
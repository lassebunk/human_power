module HumanPower
  class Rule
    attr_reader :type, :path

    def initialize(type, path)
      @type = type
      @path = path
    end

    def render
      "#{type.to_s.capitalize}: #{path}"
    end

    alias :to_s :render

    def ==(other)
      other.type == type && other.path == path
    end
  end
end
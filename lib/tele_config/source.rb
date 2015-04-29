module TeleConfig
  class Source
    def self.parameters
      @parameters ||= {}
    end

    def self.param(name, default: nil)
      parameters[name] = default

      attr_reader name
    end

    def self.descendants
      ObjectSpace.each_object(Class).select { |klass| klass < self }
    end

    def initialize(params)
      self.class.parameters.each do |key, default|
        instance_variable_set "@#{key}", params.fetch(key, default)
      end
    end

    def read
      raise NotImplementedError
    end
  end
end

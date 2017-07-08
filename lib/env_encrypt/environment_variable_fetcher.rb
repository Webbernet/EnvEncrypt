module Config
  class EnvironmentVariableFetcher
    def self.fetch(name)
      ENV[name.to_s]
    end
  end
end

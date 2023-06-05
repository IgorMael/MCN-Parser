require 'mechanize'

module MeuCarroNovo
  class Base
    BASE_URL = 'www.meucarronovo.com.br'

    def self.call(*args)
      new(*args).call
    end

    def initialize(options)
      @options = options
    end

    protected

    def agent
      @agent ||= Mechanize.new
    end
  end
end

require_relative './base'

module MeuCarroNovo
  class Search < Base
    ENDPOINT = '/api/v2/busca'

    def call
      validate
      url = URI::HTTPS.build(host: BASE_URL, path: ENDPOINT, query: URI.encode_www_form(@options))
      JSON.parse(agent.get(url).body)['documentos']
    end

    private

    def validate
      if @options.slice(
        :cidade, :uf, :ddd
      ).values.empty?
        raise ArgumentError,
              'É necessário especificar uma cidade, UF ou ddd. Use --help para mais informações.'
      end
    end
  end
end

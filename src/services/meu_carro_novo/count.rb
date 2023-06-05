require_relative './base'

module MeuCarroNovo
  class Count < Base
    ENDPOINT = '/api/v2/busca'

    def call
      url = URI::HTTPS.build(host: BASE_URL, path: ENDPOINT,
                             query: URI.encode_www_form(@options.merge(limite: 1, pagina: 1)))
      JSON.parse(agent.get(url).body)['total']
    end
  end
end

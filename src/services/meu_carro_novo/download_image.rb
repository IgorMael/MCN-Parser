require_relative './base'

module MeuCarroNovo
  class DownloadImage < Base
    BASE_URL = 'static2.meucarronovo.com.br'
    ENDPOINT = '/imagens-dinamicas/lista/fotos/'

    def call
      begin
        attempts ||= 1
        agent.pluggable_parser.default = Mechanize::Download
        agent.get(uri).save(filename)
        filename
      rescue => e
        if (attempts += 1) < 5
          retry
        else
          puts "Erro ao baixar #{uri}. Continuando..."
        end
      end
    end

    private

    def uri
      @uri ||= URI::HTTPS.build(host: BASE_URL, path: "#{ENDPOINT}#{@options[:url]}")
    end

    def filename
      "#{$options[:image_directory].chomp('/')}/#{File.basename(@options[:url])}"
    end
  end
end

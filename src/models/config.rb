require 'optparse'

class Config
  def self.load_options
    default_config
    load_config_from_yaml
    parse_options
    load_limit
  end

  def self.load_config_from_yaml
    yaml_config = YAML.load_file('config.yml', symbolize_names: true)
    $options.merge!(yaml_config) if yaml_config.is_a?(Hash)
  rescue Errno::ENOENT
    puts "Warning: config.yml file not found. Proceeding with default configuration."
  rescue Psych::SyntaxError
    puts "Warning: Invalid config.yml file. Proceeding with default configuration."
  end

  def self.parse_options
    OptionParser.new do |opts|
      opts.banner = 'Usage: main.rb [options]'

      opts.on('-c', '--cidade NOME', 'Specify the city name') { |v| $options[:busca][:cidade] = v }
      opts.on('-e', '--uf UF', 'Specify the UF') { |v| $options[:busca][:uf] = v }
      opts.on('-d', '--ddd DDD', 'Specify the DDD') { |v| $options[:busca][:ddd] = v }
      opts.on('-o', '--output OUTPUT', 'Specify the output file') { |v| $options[:output] = v }
      opts.on('-l', '--output limite',
              'Specify the maximum number of results. Set to 0 to retrieve all results. Default: 20') do |v|
        $options[:busca][:limite] = v
      end
      opts.on('-i', '--images IMAGE_DIRECTORY', 'Specify the directory to save the images. Default: "images"') do |v|
        $options[:image_directory] = v
      end
    end.parse!
  end


  def self.load_limit
    $options[:busca][:limite] ||= MeuCarroNovo::Count.call($options[:busca].compact) unless $options[:busca][:limite]
  end

  def self.default_config
    $options = {
      busca: {
        tipo: 'A',
        pagina: 1,
        UF: nil,
        ddd: nil,
        limite: 20
      },
      image_directory: 'images/'
    }
  end
end

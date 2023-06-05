#!/usr/bin/env ruby

require 'optparse'
require_relative 'services/meu_carro_novo/search'
require_relative 'services/meu_carro_novo/count'
require_relative 'models/car'
require_relative 'models/config'

def print(cars)
  if $options[:output]
    File.write($options[:output], JSON.pretty_generate(cars))
  else
    p JSON.pretty_generate(cars)
  end
end

Config.load_options

cars = MeuCarroNovo::Search.call($options[:busca].compact)
print(Car.from_json(cars))
p 'Download finalizado.'
p "Resultado salvo em #{$options[:output]}"
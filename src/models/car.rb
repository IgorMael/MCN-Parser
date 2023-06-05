require 'json'
require_relative '../services/meu_carro_novo/download_image'

class Car
  attr_accessor :model, :brand, :value, :production_year, :model_year, :photo

  ATTRIBUTES = %w[modeloNome marcaNome preco anoFabricacao anoModelo fotoCapa].freeze

  def self.from_json(cars)
    cars.map { |car| Car.new(*car.slice(*ATTRIBUTES).values) }
  end

  def initialize(model, brand, value, production_year, model_year, photo)
    @model = model
    @brand = brand
    @value = value
    @production_year = production_year
    @model_year = model_year
    @photo = photo.empty? ? nil : MeuCarroNovo::DownloadImage.call(url: photo)
  end

  def to_json(*_args)
    {
      modelo: @model,
      marca: @brand,
      valor: @value,
      ano_fabricacao: @production_year,
      ano_modelo: @model_year,
      local_path: @photo
    }.to_json
  end
end

require 'json'
require 'yaml'
require_relative '../../src/models/car'
require_relative '../../src/services/meu_carro_novo/download_image'

RSpec.describe Car do
  let(:photo_url) { 'http://example.com/photo.jpg' }
  let(:downloaded_photo_path) { '/path/to/downloaded/photo.jpg' }
  let(:car_data) do
    {
      'modeloNome' => 'Car Model',
      'marcaNome' => 'Car Brand',
      'preco' => 10000,
      'anoFabricacao' => 2021,
      'anoModelo' => 2022,
      'fotoCapa' => photo_url
    }
  end

  describe '.from_json' do
    it 'creates an array of Car objects from JSON data' do
      json_data = [car_data]
      allow(MeuCarroNovo::DownloadImage).to receive(:call).with(url: photo_url).and_return(downloaded_photo_path)

      cars = Car.from_json(json_data)

      expect(cars).to be_an(Array)
      expect(cars.size).to eq(1)
      expect(cars.first).to be_a(Car)
      expect(cars.first.model).to eq('Car Model')
      expect(cars.first.brand).to eq('Car Brand')
      expect(cars.first.value).to eq(10000)
      expect(cars.first.production_year).to eq(2021)
      expect(cars.first.model_year).to eq(2022)
      expect(cars.first.photo).to eq(downloaded_photo_path)
    end
  end

  describe '#to_json' do
    it 'returns the car object as a JSON string' do
      allow(MeuCarroNovo::DownloadImage).to receive(:call).with(url: photo_url).and_return(downloaded_photo_path)

      car = Car.new('Car Model', 'Car Brand', 10000, 2021, 2022, photo_url)
      json_string = car.to_json

      expect(json_string).to be_a(String)

      expect(JSON.parse(json_string)).to eq({
        'modelo' => 'Car Model',
        'marca' => 'Car Brand',
        'valor' => 10000,
        'ano_fabricacao' => 2021,
        'ano_modelo' => 2022,

        'local_path' => downloaded_photo_path
      })
    end
  end
end

require_relative '../../../src/services/meu_carro_novo/search'
require 'json'

RSpec.describe MeuCarroNovo::Search do
  describe '#call' do
    let(:options) { { cidade: 'Goiânia' } }
    let(:instance) { described_class.new(options) }
    let(:response_body) { { "documentos": ['car1', 'car2'] }.to_json }
    let(:agent) { instance_double('Mechanize', get: double('response', body: response_body))  }

    before do
      allow(instance).to receive(:agent).and_return(agent)
    end

    it 'validates the options' do
      expect(instance).to receive(:validate)

      instance.call
    end

    it 'sends a GET request to the API and returns the parsed response' do
      expected_url = URI::HTTPS.build(host: described_class::BASE_URL,
                                      path: described_class::ENDPOINT,
                                      query: 'cidade=Goiânia')


      expect(agent).to receive(:get).with(expected_url)

      expect(JSON).to receive(:parse).with(response_body).and_return(JSON.parse(response_body))
      instance.call
    end
  end

  describe '#validate' do
    context 'when cidade, uf, and ddd options are not provided' do
      let(:options) { { param1: 'value1', param2: 'value2' } }
      let(:instance) { described_class.new(options) }

      it 'raises an ArgumentError with the correct message' do
        expect { instance.send(:validate) }.to raise_error(ArgumentError, /É necessário especificar uma cidade, UF ou ddd/)
      end
    end

    context 'when cidade, uf, or ddd options are provided' do
      let(:options) { { cidade: 'City', uf: nil, ddd: '' } }
      let(:instance) { described_class.new(options) }

      it 'does not raise an ArgumentError' do
        expect { instance.send(:validate) }.not_to raise_error
      end
    end
  end
end
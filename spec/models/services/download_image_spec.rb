require_relative '../../../src/services/meu_carro_novo/download_image'

RSpec.describe MeuCarroNovo::DownloadImage do
  describe '#call' do
    let(:options) { { url: 'example.jpg' } }
    let(:instance) { described_class.new(options) }
    let(:agent) { instance_double('Mechanize', get: nil) }

    before do
      $options = {image_directory:'images' }
      allow(instance).to receive(:agent).and_return(agent)
      allow(agent).to receive_message_chain(:pluggable_parser, :default=)
    end

    it 'sets the default parser for Mechanize to Mechanize::Download' do
      expect(agent.pluggable_parser).to receive(:default=).with(Mechanize::Download)

      instance.call
    end

    it 'gets the image URI and saves it with the correct filename' do
      uri = instance.send(:uri)
      expected_filename = "#{$options[:image_directory].chomp('/')}/example.jpg"

      expect(agent).to receive(:get).with(uri)

      instance.call
    end

    context 'when an error occurs during download' do
      before do
        allow(instance).to receive(:puts)
      end

      it 'retries up to 5 times' do
        expect(agent).to receive(:get).and_raise(StandardError).exactly(4).times

        instance.call
      end

      it 'outputs an error message if retries exceed the limit' do
        expect(agent).to receive(:get).and_raise(StandardError).exactly(4).times
        expect(instance).to receive(:puts).with(/Erro ao baixar #{instance.send(:uri)}. Continuando.../)

        instance.call
      end
    end
  end

  describe '#uri' do
    let(:options) { { url: 'example.jpg' } }
    let(:instance) { described_class.new(options) }

    it 'builds the URI with the correct host and path' do
      expected_uri = URI::HTTPS.build(host: described_class::BASE_URL,
                                      path: "#{described_class::ENDPOINT}#{options[:url]}")

      expect(instance.send(:uri)).to eq(expected_uri)
    end
  end

  describe '#filename' do
    let(:options) { { url: 'example.jpg' } }
    let(:instance) { described_class.new(options) }

    before do
      $options = { image_directory: 'images/' }
    end

    it 'returns the correct filename based on the image URL and image directory' do
      expected_filename = 'images/example.jpg'

      expect(instance.send(:filename)).to eq(expected_filename)
    end
  end
end
require 'mechanize'
require_relative '../../../src/services/meu_carro_novo/base'

RSpec.describe MeuCarroNovo::Base do
  describe '#initialize' do
    let(:options) { { param1: 'value1', param2: 'value2' } }
    let(:instance) { described_class.new(options) }

    it 'stores the options' do
      expect(instance.instance_variable_get(:@options)).to eq(options)
    end
  end

  describe '#agent' do
    let(:instance) { described_class.new({}) }

    it 'creates and returns a Mechanize agent' do
      expect(Mechanize).to receive(:new).and_call_original

      agent = instance.send(:agent)

      expect(agent).to be_an_instance_of(Mechanize)
      expect(instance.instance_variable_get(:@agent)).to eq(agent)
    end

    it 'memoizes the agent' do
      agent1 = instance.send(:agent)
      agent2 = instance.send(:agent)

      expect(agent1).to eq(agent2)
    end
  end
end

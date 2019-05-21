# frozen_string_literal: true

describe Helpers::Parser do
  let(:text) do
    File.open(File.expand_path('./spec/fixtures/test.txt')).read
  end

  let(:new_instance) do
    described_class.new(text)
  end

  describe 'when #success' do
    it 'returns the name from text' do
      expect(new_instance.extract_user_name).to eql 'FOO_NAME'
    end

    it 'returns a list of table items' do
      expect(new_instance.extract_scores).to be_a(Array)
      expect(new_instance.extract_scores).not_to be_empty
    end
  end

  describe 'when #failure' do
    context 'when no text provided' do
      it 'name returns an empty string' do
        expect(described_class.new('').extract_user_name).to eql ''
      end

      it 'scores return an empty array' do
        expect(described_class.new('').extract_scores).to eql []
      end
    end
  end
end

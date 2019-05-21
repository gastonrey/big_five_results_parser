# frozen_string_literal: true

describe BigFiveResultsTextSerializer do
  let(:input_text) do
    File.open(File.expand_path('./spec/fixtures/test.txt')).read
  end

  let(:described_class_instance) do
    described_class.new(input_text)
  end

  context 'when #success' do
    describe '#to_h' do
      let(:new_hash) do
        described_class_instance.to_h
      end

      it 'is a hash' do
        expect(new_hash).to be_a(Hash)
      end

      it 'has a :NAME key' do
        expect(new_hash).to have_key('NAME')
      end

      it 'contains EXTRAVERSION overall_scores' do
        expect(new_hash['EXTRAVERSION'][:overall_scores]).to eql('66')
      end

      it 'contains AGREEABLENESS overall_scores' do
        expect(new_hash['AGREEABLENESS'][:overall_scores]).to eql('91')
      end

      it 'contains CONSCIENTIOUSNESS overall_scores' do
        expect(new_hash['CONSCIENTIOUSNESS'][:overall_scores]).to eql('72')
      end
    end
  end

  context 'when #failure' do
    describe 'when any score has been parsed' do
      let(:new_hash) do
        described_class_instance.to_h
      end

      before do
        dummy_parser = instance_double(Helpers::Parser)
        allow(Helpers::Parser).to receive(:new).and_return(dummy_parser)
        allow(dummy_parser).to receive(:extract_scores).and_return([])
        allow(dummy_parser).to receive(:scores).and_return([])
      end

      it 'then returns an empty hash' do
        expect(new_hash).to be_empty
      end
    end
  end
end

# frozen_string_literal: true

describe BigFiveResultsPoster do
  let(:successful_rsp) do
    Typhoeus::Response.new(
      response_code: 201,
      body: 'Fgfh23423234'
    )
  end

  let(:failure_rsp) do
    Typhoeus::Response.new(
      response_code: 422,
      body: 'Some error'
    )
  end

  describe 'when #Success' do
    context 'when a new instance is created' do
      let(:new_instance) do
        described_class.new({ score: 50, name: 'foo' }, 'foo@bar')
      end

      let(:data_hash) do
        new_instance.instance_variable_get(:@results_hash)
      end

      it 'then variable instance has #EMAIL key and value' do
        expect(data_hash).to have_key('EMAIL')
        expect(data_hash['EMAIL']).to eql('foo@bar')
      end
    end

    context 'when #post' do
      subject(:new_instance) do
        described_class.new({ score: 50, name: 'foo' }, 'foo@bar').post
      end

      before do
        allow(Typhoeus).to receive(:post).and_return successful_rsp
      end

      it { new_instance.success? == true }
      it { new_instance.response_code == 201 }
      it { new_instance.body == 'Fgfh23423234' }
    end
  end

  describe 'when #Failure' do
    it 'then raises an exception when no email provided' do
      expect do
        described_class.new({ score: 50, name: 'foo' }, nil)
      end.to raise_error('Email required')
    end
  end
end

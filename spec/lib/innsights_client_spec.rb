require_relative '../../lib/innsights_client'

describe InnsightsClient do
  let(:actions){ [ {subdomain: 'Aventones', action_group: 313}, 
                   {subdomain: 'Sharewall', action_group: 998}]}
  subject{InnsightsClient.new actions}

  describe '#execute' do
    it 'Fetches the information from the url and params '
    it 'Returns a hash with the response body'
  end

  describe '#data' do
    context 'When resposne' do
      it 'Returns the tweets'
    end

    context 'Without response' do
      xit { subject.data.should == nil }
    end

  end
end

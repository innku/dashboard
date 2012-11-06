require_relative '../../lib/sharewall_average_clicks_client'

describe SharewallAverageClicksClient do
  let(:url){'http://someurl.com'}
  subject{SharewallAverageClicksClient.new url}

  describe '#execute' do
    before do
      RestClient.stub(:get){ stub(body: [ {the: 'body'} ].to_json)}
    end
    it 'Fetches the information from the url and params ' do
      RestClient.should_receive(:get).with(url)
      subject.execute
    end

    it 'Returns a hash with the response body' do
      subject.execute.should == [{'the' => 'body'}]
    end
  end

  describe '#data' do
    context 'When resposne' do
      before do
        response = [ {'click_count' => 1, 'user' => {'name' => 'name1'}},
                     {'click_count' => 0, 'user' => {'name' => 'name2'}},
                     {'click_count' => 2, 'user' => {'name' => 'name1'}},
                     {'click_count' => 2, 'user' => {'name' => 'name1'}},
                     {'click_count' => 5, 'user' => {'name' => 'name3'}}]

        subject.instance_variable_set('@response', response)
      end
      it 'Returns the tweets' do
        subject.data.should == [{label: 'name3', value: 5.0},
                                {label: 'name1', value: 1.67},
                                {label: 'name2', value: 0.0}]
                                
      end
    end

    context 'Without response' do
      it { subject.data.should == nil }
    end


  end
end

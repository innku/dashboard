require_relative '../../lib/sharewall_client'

describe SharewallClient do
  let(:url){'http://someurl.com'}
  subject{SharewallClient.new url}

  describe '#execute' do
    before do
      RestClient.stub(:get){ stub(body: [{the: 'body'}].to_json)}
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
        response = [ {'title' => 'Some text', 'created_at' =>'Time', 
                      'user' => {'name' => 'name', 'image_url' => 'image.png', 
                                'other' => 'not'}} ]
        subject.instance_variable_set('@response', response)
      end
      it 'Returns the tweets' do
        subject.data.should == [{name: 'name', avatar: 'image.png', 
                                body: 'Some text'}]
      end
    end

    context 'Without response' do
      it { subject.data.should == nil }
    end

  end
end

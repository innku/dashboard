require_relative '../../lib/twitter_client'

describe TwitterClient do
  let(:url){'http://someurl.com'}
  let(:params){{parameter: 1}}
  subject{TwitterClient.new(url, params)}

  describe '#execute' do
    before do
      RestClient.stub(:get){ stub(body: {the: 'body'}.to_json)}
    end
    it 'Fetches the information from the url and params ' do
      RestClient.should_receive(:get).with(url, params: params)
      subject.execute
    end

    it 'Returns a hash with the response body' do
      subject.execute.should == {'the' => 'body'}
    end
  end

  describe '#data' do
    context 'When resposne' do
      before do
        response = [ {'text' => 'Some text', 'created_at' =>'Time', 
                      'user' => {'screen_name' => 'name', 'profile_image_url' => 'image.png', 
                                'other' => 'not'}} ]
        subject.instance_variable_set('@response', response)
      end
      it 'Returns the tweets' do
        subject.data.should == [{name: 'name', avatar: 'image.png', title: 'Some text'}]
      end
    end

    context 'Without response' do
      it { subject.data.should == nil }
    end

  end

end

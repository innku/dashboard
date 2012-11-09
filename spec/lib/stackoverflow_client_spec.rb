require_relative '../../lib/stackoverflow_client'

describe StackoverflowClient do
  let(:url){'http://someurl.com'}
  let(:default_params){ 
    StackoverflowClient::DEFAULT_PARAMS
  }
  let(:user_hash) {
    {
      103076 => 'Elias'
    }
  }
  subject{StackoverflowClient.new user_hash, url}


  describe '#execute' do
    before do
      RestClient.stub(:get) { stub(body: [{the: 'body'}].to_json)}
    end
    it 'Fetches the information from the url and params' do
      url_with_userid = "#{url}/103076"
      RestClient.should_receive(:get).with(url_with_userid, params: default_params)
      subject.execute
    end

    it 'Returns a hash with the response body' do
      subject.execute.should == [{'the' => 'body'}]
    end
  end

  describe '#data' do
    context 'When response' do
      before do
        response = {
          "items" => [
            {
              "user_id" => 103076,
              "reputation" => 895,
              "reputation_change_week" => 0
            }
          ]
        }
        subject.instance_variable_set('@response', response)
      end
      it 'Returns the users with its reputation' do
        subject.data.should == [{label: 'Elias', value: 895}]
      end
    end

    context 'Without response' do
      it { subject.data.should == nil }
    end

  end
end

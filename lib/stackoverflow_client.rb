require 'rest_client'
require 'json'

class StackoverflowClient
  attr_accessor :url, :user_hash

  ACTION_URL= 'https://api.stackexchange.com/2.1/users'
  DEFAULT_PARAMS = {
      sort: 'reputation',
      site: 'stackoverflow',
      order: 'desc'
  }

  def initialize user_hash = {}, url=ACTION_URL
    @url = url
    @user_hash = user_hash
  end

  def execute
    raw_response = RestClient.get(url_with_userids, params: DEFAULT_PARAMS)
    @response = JSON.parse(raw_response.body)
  end

  def data
    if @response
      @data = parse_response
    end
  end

  private

  def self.default_params
  end

  def url_with_userids
    "#{url}/#{user_ids}"
  end

  def user_ids
    user_hash.keys.join(';')
  end

  def parse_response
    @response['items'][0..5].map do |link|
      {
        label: user_hash[link['user_id']],
        value: link['reputation'].to_i
      }
    end
  end
end

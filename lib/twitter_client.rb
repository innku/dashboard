require 'json'
require 'rest_client'

class TwitterClient

  def initialize url, params
    @url = url
    @params = params
  end

  def execute
    raw_response = RestClient.get @url, params: @params
    @response = JSON.parse(raw_response.body)
  end

  def data
    if @response
    return @response.map do |tweet| 
      { 
        name: tweet['user']['screen_name'], 
        avatar: tweet['user']['profile_image_url'],
        body: tweet['text']
      }
    end
    end
  end
  
end

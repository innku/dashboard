require 'rest_client'
require 'json'

class SharewallClient
  attr_accessor :url

  def initialize url
    @url = url
  end

  def execute
    raw_response = RestClient.get(url)
    @response = JSON.parse raw_response.body
  end

  def data
    if @response
      @response.map do |link|
        { 
          body: link['title'], 
          name: link['user']['name'], 
          avatar: link['user']['image_url'] 
        }
      end
    end
  end

end

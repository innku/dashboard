require 'rest_client'
require 'json'

class SharewallAverageClicksClient
  attr_accessor :url

  def initialize url
    @url = url
  end

  def execute
    raw_response = RestClient.get(url)
    @response = JSON.parse(raw_response.body).reverse[0..19]
  end

  def data
    if @response
      @data = parse_response
      @data = get_average(group_by_users(@data))
      @data = sort @data
      @data[0..4]
    end
  end

  private

  def parse_response
    @response.map do |link|
      { 
        label: link['user']['name'],
        value: link['click_count']
      }
    end
  end

  def group_by_users(links)
    links.group_by { |link| link[:label]} 
  end

  def get_average links
    links.map do |key, link_group|
      total = 0
      link_group.each do |link|
        total += link[:value] || 0
      end
      {
        label: key,
        value: (total.to_f/link_group.size).round(2)
      }
    end

  end

  def sort links
    links.sort_by{|link| -link[:value]}
  end

end

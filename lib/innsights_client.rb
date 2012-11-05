require 'rest_client'
require 'json'

class InnsightsClient

  attr_accessor :base_url, :actions
  
  def initialize actions, options={}
    @actions = actions
    @base_url = options[:url] || "innsights.me/production/api/timeline.json"
  end

  def execute
    @response = actions.map do |action|
      url      = "http://#{action[:subdomain]}.#{base_url}"
      response = RestClient.get(url, params: action)
      [action, (JSON.parse response)]
    end
  end

  def data
    @reports = @response.map do |action, report|
      {label: (action[:name] || action[:subdomain]), 
        value: report['total'],
        current: report['total'],
        last: report['velocity']}
    end
    @reports = @reports.sort_by {|report| -report[:value]}
  end

end

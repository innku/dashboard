url = 'http://sharewall.herokuapp.com/links.json'

SCHEDULER.every '5m', :first_in => 0 do |job|
  client = SharewallAverageClicksClient.new url
  client.execute
  send_event('sharewall_click_count', items: client.data)
end

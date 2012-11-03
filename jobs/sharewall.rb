require 'rest_client'
require 'json'

url = 'http://sharewall.herokuapp.com/links.json'

SCHEDULER.every '5m', :first_in => 0 do |job|
  client = SharewallClient.new url
  client.execute
  send_event('sharewall_links', links: client.data)
end

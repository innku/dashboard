actions   = [ { subdomain: 'bustracker', scope: { event: { name: 'Go To Buy' } } } ]

SCHEDULER.every '5m', :first_in => 0 do |job|
  client = InnsightsClient.new actions
  client.execute
  data = client.data.first
  send_event('ir_a_comprar',
             {current: data[:current], last: data[:last]})
end

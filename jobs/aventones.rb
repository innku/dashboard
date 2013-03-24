# coding: utf-8

actions   = [ 
              {subdomain: 'aventones', scope: { event: { name: 'Confirmación si'} } }
            ]

SCHEDULER.every '5m', :first_in => 0 do |job|
  client = InnsightsClient.new actions
  client.execute
  data = client.data.first
  send_event('aventones_confirmados', 
             {current: data[:current], last: data[:last]})
end

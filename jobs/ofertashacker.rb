# encoding: utf-8;

actions   = [
              {subdomain: 'rubypros', scope: { event: { name: 'Compañia contactada' } } }
            ]

SCHEDULER.every '5m', :first_in => 0 do |job|
  client = InnsightsClient.new actions
  client.execute
  data = client.data.first
  send_event('companias_contactadas', 
             {current: data[:current], last: data[:last]})
end

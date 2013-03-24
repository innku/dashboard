# encoding: utf-8;

actions   = [ 
              {subdomain: 'cocina', scope: { event: { name: 'Impresión de receta' } } }
            ]

SCHEDULER.every '5m', :first_in => 0 do |job|
  client = InnsightsClient.new actions
  client.execute
  data = client.data.first
  send_event('imprimir_receta',
             {current: data[:current], last: data[:last]})
end

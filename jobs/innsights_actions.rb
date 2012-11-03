actions   = [ 
              {subdomain: 'Aventones', action_group: 313},
              {subdomain: 'Sharewall', action_group: 998},
              {subdomain: 'Cocina',    action_group: 372},
              {subdomain: 'Puraoferta',action_group: 655},
              {subdomain: 'Pinstad',   action_group: 566},
              {subdomain: 'Rutanet',   action_group: 5, name: 'Rutantet (Enviador)'}
            ]

SCHEDULER.every '5m', :first_in => 0 do |job|
  client = InnsightsClient.new actions
  client.execute
  send_event('user_registration', items: client.data)
end

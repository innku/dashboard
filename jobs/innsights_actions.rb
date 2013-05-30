actions   = [
              {subdomain: 'aventones', :scope=>{:event=>{:name=>"Registro de usuario"}}},
              {subdomain: 'cocina',    :scope=>{:event=>{:name=>"Nuevo usuario"}}},
              {subdomain: 'bustracker', :scope=>{:event=>{:name=>"Search Lead"}}},
              {subdomain: 'pinstad',   :scope=>{:event=>{:name=>"User register"}}},
              {subdomain: 'rutanet',   :scope=>{:event=>{:name=>"transportista"}}},
              {subdomain: 'interciudades', :scope=>{:event=>{:name=>"Registro de usuario"}}},
            ]

SCHEDULER.every '5m', :first_in => 0 do |job|
  client = InnsightsClient.new actions
  client.execute
  send_event('user_registration', items: client.data)
end

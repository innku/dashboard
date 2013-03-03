user_hash = {
  800254 => 'rogeliog',
  103076 => 'gajon',
  314346 => 'macario',
  562692 => 'e3matheus',
  803847 => 'marrossa',
  803844 => 'adriancuadros',
  504059 => 'eddie',
  800271 => 'j->p',
  481229 => 'agush',
  892885 => 'mike r',
  657355 => 'braulio'
}

SCHEDULER.every '5m', :first_in => 0 do |job|
  client = StackoverflowClient.new user_hash
  client.execute
  send_event('stackoverflow_reputation', items: client.data)
end

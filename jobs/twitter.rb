url = 'https://api.twitter.com/1/lists/statuses.json'
params = {slug:'twitter-4-innku', owner_screen_name: 'innku', 
          per_page: 10, page: 1}

SCHEDULER.every '5m', :first_in => 0 do |job|
  client = TwitterClient.new url, params
  client.execute
  send_event('tweets', links: client.data)
end

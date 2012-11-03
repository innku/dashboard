require 'rest_client'
require 'json'


url = 'http://sharewall.herokuapp.com/links.json'

SCHEDULER.every '5m', :first_in => 0 do |job|
  response = RestClient.get url
  links = JSON.parse(response).reverse[0..5]

  if links
    links.map! do |link| 
      { 
        body: link['title'], 
        name: link['user']['name'], 
        avatar: link['user']['image_url'] 
      }
    end
  
    send_event('sharewall_links', links: links)
  end
end

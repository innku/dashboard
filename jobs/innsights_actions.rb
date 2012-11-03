require 'rest_client'
require 'json'

actions   = [ 
              {subdomain: 'Aventones', action_group: 313},
              {subdomain: 'Sharewall', action_group: 998},
              {subdomain: 'Cocina',    action_group: 372},
              {subdomain: 'Puraoferta',action_group: 655},
              {subdomain: 'Pinstad',   action_group: 566},
              {subdomain: 'Rutanet',   action_group: 5, name: 'Rutantet (Enviador)'}
            ]

SCHEDULER.every '5m', :first_in => 0 do |job|
  actions.map! do |action|
    report = get_report_for action
    {label: (action[:name] || action[:subdomain]), value: report['total']}
  end

  actions = actions.sort_by {|action| -action[:value]}
  send_event('user_registration', items: actions)
end

def get_report_for action
  url      = "http://#{action[:subdomain]}.innsights.me/production/api/timeline.json"
  response = RestClient.get(url, params: {action_group: action[:action_group]})
  JSON.parse response 
end

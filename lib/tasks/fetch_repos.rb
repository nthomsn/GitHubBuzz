require 'rest-client'
require 'json'

def get_page(p)
  url = 'https://api.github.com/search/repositories'
  response = RestClient.get(url, {:params => 
    {:q => 'stars:>1', 
     :sort => 'stars', 
     :order => 'desc',
     :page => p,
     :per_page => 1000}})
  return JSON.parse(response)
end

repos = Array.new
(1..10).each do |page|
  repos += get_page(page)["items"]
end

File.open("stars.json","w") do |f|
  f.write(JSON.pretty_generate(repos))
end

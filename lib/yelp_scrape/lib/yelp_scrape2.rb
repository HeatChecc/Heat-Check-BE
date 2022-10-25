require "nokogiri"
require 'faraday'

# -- got shut out, no luck -- #

response = Faraday.new("https://www.yelp.com/").get("biz/q-house-denver") # might need different pathway to get dishes from this menu - hidden in different HTML tag

html = response.body
doc = Nokogiri::HTML(html)

results = []
doc.css("p").each do |element|
  if element.attributes["class"].value[-10..-1] == "css-nyjpex"
    results << element.children.text
  end
end

results

require 'pry'; binding.pry
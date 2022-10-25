# require 'open-uri'
# require 'net/http'
# require 'json'
require "nokogiri"
require 'faraday'

# -- Start by accessing page w Faraday + Nokogiri, parse specific  CSS tag to find data

response = Faraday.new("https://www.yelp.com/").get("menu/szechuan-tasty-house-denver-3")
# response_2 = Faraday.new("https://www.yelp.com/").get("menu/yum-yum-spice-denver-2")
# response_3 = Faraday.new("https://www.yelp.com/").get("biz/q-house-denver") -> might need different pathway to get dishes from this menu - hidden in different HTML tag


html = response.body
doc = Nokogiri::HTML(html)


results = []
doc.css("a").each do |element| 
  name = element.children.text
  arr = name.downcase.split(" ")
  arr.each do |phrase|
    if element.attributes["href"]
      if element.attributes["href"].value.include?(phrase) 
        results << name
      end
    end
  end
end

# -- filter method section -- # (Find non-yelp related data from "a" HTML tag)

possible = results.uniq
ignore_list = [ "write", "yelp", "review", "reviews", "about", "sign", "services", "auto", "careers", "log", "restaurants", "business", "privacy", "policy", "members", "press", "trust", "safety", "content", "collections", "talk", "events", "support", "developers", "rss", "blog", "management", "photos" ]


arr = []
possible.each do |phrase|
  phrase.downcase.split(" ").each do |word|
    if ignore_list.include?(word)
      arr << phrase
    end
  end
end

non_dish = arr.uniq
dishes = possible - non_dish

# -- Format dishes, get rid of numbers & extra spaces in front of name -- #

extra = ["."] + ((0..9).to_a).map {|n| n.to_s }
formatted = []

dishes.each do |name|
  name.each_char.with_index do |char, idx|
    if extra.include?(char) && idx < 3
      name.delete!(char)
    elsif name.split("")[0] == " "
      arr = name.split("")
      arr.delete_at(0)
      formatted << arr.join
    else
      formatted << name
    end
  end
end

menu = formatted.uniq

require 'pry'; binding.pry

#  -- pseudo code for getting rid of numerals at beginning of dishes -- #

#     dishes.each_with_index do |name| 
  #  if name[first 4 characters] == " ", ".", "0..9" delete that character at that index







# html = URI.open("https://www.yelp.com/menu/toro-denver-2") # --- Yelp is not cool with you scraping their shit with openuri for some reason - 503 error

# -- Google Search Scrape attempt, too deep into pages for valuable iteration to happen
# url = "https://www.google.com/search?q=toro+restaurant+denver"

# uri = URI.parse(url)

# response = Net::HTTP.get_response(uri)
# html = response.body
# doc = Nokogiri::HTML(html)

# menu_search = doc.css("a")
# pages = []
# menu_search.each do |e|
#   if e.attributes.values.first.value.include?("menu" || "Menu")
#     pages << e.attributes.values.first.value
#   end
# end

# pages

# page = URI.open(pages.first[7..39])
# menu = Nokogiri::HTML(page)


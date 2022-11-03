module DishHelper
  def scrape_conn
    Faraday.new("https://www.yelp.com/")
  end
  
  def doc_results
    if @alias != "Not found"
      response = scrape_conn.get("menu/#{@alias}")
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
      results
    else
      []
    end
  end

  def biz_dishes_arr
    if @alias == "Not found"
      []
    else
      response = Faraday.new("https://www.yelp.com/").get("biz/#{@alias}")
      html = response.body
      doc = Nokogiri::HTML(html)
      results = []
      doc.css("p").each do |element|
        if element.attributes["class"].value[-10..-1] == "css-nyjpex"
          results << element.children.text
        end
      end
      results
    end
  end

  def dish_filter
    possible = doc_results.uniq
    ignore_list = [ "write", "menu", "yelp", "review", "reviews", "about", "sign", "services", "auto", "careers", "log", "restaurants", "business", "privacy", "policy", "members", "press", "trust", "safety", "content", "collections", "talk", "events", "support", "developers", "rss", "blog", "management", "photos", "photo" ]
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
    return dishes
  end

  def formatted
    extra = ["."] + ((0..9).to_a).map {|n| n.to_s }
    formatted = []
    dish_filter.each do |name|
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
    formatted.uniq
  end

  def first_cuisine
    cuisine = categories.split(" ")
    cuisine.each do |c|
      if c.include?(",")
        c.delete!(",")
      end
    end
    cuisine[0]
  end

  def html_to_ruby
    formatted.map do |dish_name|
      Dish.create!(
        name: dish_name,
        cuisine_type: first_cuisine,
        yelp_id: @id,
        spice_rating: nil
      )
    end
  end

  def html_to_ruby_biz
    biz_dishes_arr.map do |dish_name|
      Dish.create!(
        name: dish_name,
        cuisine_type: first_cuisine,
        yelp_id: @id,
        spice_rating: nil
      )
    end
  end

  def html_dishes
    html_to_ruby
    extra = Dish.where(name: @name)
    if extra[0]
      extra[0].destroy
    end
  end

  def biz_dishes
    html_to_ruby_biz
  end
end
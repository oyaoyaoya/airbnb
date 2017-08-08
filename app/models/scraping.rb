class Scraping
  def self.places
    agent = Mechanize.new
    links = []

    while true
      current_page = agent.get("https://www.airbnb.com/s/places")
      elements = current_page.search('.image_ay4wjb-o_O-background_1h6n1zu-o_O-fadeIn_3jddj2-o_O-backgroundSize_cover_176vplr')
      elements.each do |ele|
        links << ele.get_attribute('href')
      end

      # next_link = current_page.at('.next_page')
      next_url = next_link.get_attribute('href')

      break unless next_url
    end
    links.each do |link|
      get_product('https://www.airbnb.com/s/places' + link)
    end
  end

  def self.places(link)
    agent = Mechanize.new
    page = agent.get(link)
    title = page.at('.moveInfoBox h1').inner_text
    image_url = page.at('.pictBox img')[:src] if page.at('.pictBox img')
    director = page.at('.f span').inner_text if page.at('.f span')
    detail = page.at('.outline p').inner_text
    open_date = page.at('.opn_date strong').inner_text if page.at('.opn_date strong')

    product = Product.where(title: title, image_url: image_url).first_or_initialize
    product.director = director
    product.detail = detail
    product.open_date = open_date
    product.save
  end
end

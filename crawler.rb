require 'nokogiri'
require 'pry'
require 'open-uri'
require 'net/http'


url = 'https://www.amazon.pl/gp/bestsellers/grocery'

html = Net::HTTP.get(URI.parse(url))

doc = Nokogiri::HTML(html)

productsInfo = Hash.new

products = doc.css('#gridItemRoot').css('.zg-grid-general-faceout')

# puts products.length()

for a in 0..products.length()-1 do
    product = products[a]
    name = ""
    one = product.css('._p13n-zg-list-grid-desktop_truncationStyles_p13n-sc-css-line-clamp-4__2q2cc')
    two = product.css('._p13n-zg-list-grid-desktop_truncationStyles_p13n-sc-css-line-clamp-3__g3dy1')
    if one.length != 0
        name = product.css('._p13n-zg-list-grid-desktop_truncationStyles_p13n-sc-css-line-clamp-4__2q2cc').inner_text
    end
    if two.length != 0
        name = product.css('._p13n-zg-list-grid-desktop_truncationStyles_p13n-sc-css-line-clamp-3__g3dy1').inner_text
    end
    price = product.css(".p13n-sc-price").inner_text

    productsInfo[name] = price
   end

puts productsInfo
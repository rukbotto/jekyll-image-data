require "nokogiri"

module JekyllImageData
  class Crawler
    def crawl(content)
      images = []
      html = Nokogiri::HTML(content)
      html.xpath("//img").each do |item|
        src = item.xpath("@src").first
        alt = item.xpath("@alt").first
        images << {
          "url" => src ? src.content : "",
          "alt" => alt ? alt.content : ""
        }
      end
      images
    end
  end
end

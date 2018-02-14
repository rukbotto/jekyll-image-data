require "nokogiri"

module JekyllImageData
  class Crawler
    def crawl(content)
      images = []
      html = Nokogiri::HTML(content)
      html.xpath("//img").each do |item|
        images << {
          "url" => item.xpath("@src").first.content,
          "alt" => item.xpath("@alt").first.content
        }
      end
      images
    end
  end
end

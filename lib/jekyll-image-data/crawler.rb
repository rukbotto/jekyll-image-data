require "nokogiri"

module JekyllImageData
  class Crawler
    def crawl(content, config)
      images = []
      exclude = config.dig("image_data", "exclude") || []
      html = Nokogiri::HTML(content)
      html.xpath("//img").each do |item|
        src = item.xpath("@src").first
        alt = item.xpath("@alt").first
        excluded = exclude.select do |exclude_item|
          src.value.include?(exclude_item)
        end
        next unless excluded.empty?
        images << {
          "url" => src ? src.content : "",
          "alt" => alt ? alt.content : ""
        }
      end
      images
    end
  end
end

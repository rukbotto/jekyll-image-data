module JekyllImageData
  class Crawler
    def initialize
      @alt = %r{!\[(.*)\]}
      @url = %r{([\w/:.-]+\.?(jpg|png|gif)?)}
      @tag = %r{\[(.*)\]}
      @image = %r{#{@alt}(\(#{@url}\)|#{@tag})}
      @reference = %r{#{@tag}: +#{@url}}
    end

    def crawl(content)
      images = []

      content.scan(@image) do |match|
        if $3
          images << { "alt" => "#{$1}", "url" => "#{$3}" }
        elsif $5
          images << { "alt" => "#{$1}", "url" => "#{$5}" }
        end
      end

      content.scan(@reference) do |match|
        images.map do |image|
          image["url"] = $2 if image["url"] == $1
        end
      end

      images
    end
  end
end

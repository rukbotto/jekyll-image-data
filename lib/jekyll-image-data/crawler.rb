module JekyllImageData
  class Crawler
    def initialize
      src = %r{(?:https|http|mailto)?(?:\:/)?/\S+}
      alt = %r{[[[:alnum:]][[:space:]]`~¡!@\#\$%^&*\(\)+=\[\]\{\}\\\|;\:',\.¿\?/_-]+}

      md_image = %r{!\[(.*)\]\((.*)\)}
      md_image_ref = %r{!\[(.*)\]\[(.*)\]}
      html_image = %r{<img.*(src="(#{src})".*alt="(#{alt})"|alt="(#{alt})".*src="(#{src})"|src="(#{src})")}
      include_image = %r{\{\%\s*include\s*image.(liquid|html)\s*(src="(#{src})".*alt="(#{alt})"|alt="(#{alt})".*src="(#{src})")}

      @image = %r{#{md_image}|#{md_image_ref}|#{html_image}|#{include_image}}
      @image_ref = %r{\[(.*)\]:\s*(\S*)}
    end

    def crawl(content, config)
      images = []
      exclude = config.dig("image_data", "exclude") || nil

      content.scan(@image) do |match|
        src = match[1] || match[5] || match[8] || match[9] || match[12] || match[15] || ""
        alt = match[0] || match[2] || match[6] || match[7] || match[13] || match[14] || ""
        ref = match[3] || ""
        images << { "url" => src, "alt" => alt, "ref" => ref }
      end

      content.scan(@image_ref) do |match|
        images.each do |image|
          image["url"] = match[1] if image["ref"] == match[0]
        end
      end

      images.each do |image|
        image.delete("ref")
        images.delete(image) if exclude and Regexp.new(exclude).match(image["url"])
      end

      images
    end
  end
end

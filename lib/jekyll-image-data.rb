require "jekyll"
require "jekyll-image-data/crawler"
require "jekyll-image-data/version"

module JekyllImageData
  @crawler = Crawler.new

  Jekyll::Hooks.register :documents, :pre_render do |document|
    document.data["images"] = @crawler.crawl(document.content, document.site.config)
  end

  Jekyll::Hooks.register :pages, :post_init do |page|
    page.data["images"] = @crawler.crawl(page.content, page.site.config)
  end
end

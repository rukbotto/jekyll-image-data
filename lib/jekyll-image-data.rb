require "jekyll"
require "jekyll-image-data/crawler"
require "jekyll-image-data/version"

module JekyllImageData
  @crawler = Crawler.new

  Jekyll::Hooks.register :posts, :pre_render do |post|
    post.data["images"] = @crawler.crawl(post.content, post.site.config)
  end

  Jekyll::Hooks.register :pages, :pre_render do |page|
    page.data["images"] = @crawler.crawl(page.content, page.site.config)
  end
end

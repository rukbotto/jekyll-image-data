require "jekyll"
require "jekyll-image-data/crawler"
require "jekyll-image-data/version"

module JekyllImageData
  @crawler = Crawler.new

  Jekyll::Hooks.register :posts, :pre_render do |post, payload|
    post.data["images"] = @crawler.crawl(post.content)
  end

  Jekyll::Hooks.register :pages, :pre_render do |page, payload|
    page.data["images"] = @crawler.crawl(page.content)
  end
end

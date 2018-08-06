require "spec_helper"

describe JekyllImageData::Crawler do
  let(:overrides) { Hash.new }
  let(:site_config) do
    Jekyll.configuration(Jekyll::Utils.deep_merge_hashes({
      "source" => File.expand_path("../fixtures/image-data", __FILE__),
      "destination" => File.expand_path("../dest", __FILE__)
    }, overrides))
  end
  let(:site) { Jekyll::Site.new(site_config) }
  let(:post_images) { site.posts[0].data["images"] }
  let(:page_images) { site.pages[0].data["images"] }

  before(:each) do
    site.process
  end

  context "When post contains images in Markdown format" do
    describe "Crawler.crawl" do
      it "crawls png image data" do
        expect(post_images[0]["url"]).to eq("/media/images/800x600.png")
        expect(post_images[0]["alt"]).to eq("800x600 png")
      end

      it "crawls jpg image data" do
        expect(post_images[1]["url"]).to eq("/media/images/800x600.jpg")
        expect(post_images[1]["alt"]).to eq("800x600 jpg")
      end

      it "crawls gif image data" do
        expect(post_images[2]["url"]).to eq("/media/images/800x600.gif")
        expect(post_images[2]["alt"]).to eq("800x600 gif")
      end

      it "crawls image data if 'url' attr has an external URL" do
        expect(post_images[3]["url"]).to eq("http://placehold.it/800x600")
        expect(post_images[3]["alt"]).to eq("800x600 http")
      end

      it "doesn't crawl image data if image is excluded from crawling" do
        expect(post_images[9]).to be_nil
      end
    end
  end

  context "When post contains plain HTML images" do
    describe "Crawler.crawl" do
      it "crawls image data" do
        expect(post_images[4]["url"]).to eq("http://placehold.it/800x600")
        expect(post_images[4]["alt"]).to eq("800x600 http")
      end

      it "crawls image data if 'alt' attr is not present" do
        expect(post_images[8]["url"]).to eq("http://placehold.it/800x600")
        expect(post_images[8]["alt"]).to eq("")
      end
    end
  end

  context "When post contains images as liquid files" do
    describe "Crawler.crawl" do
      it "crawls image data" do
        expect(post_images[5]["url"]).to eq("http://placehold.it/800x600")
        expect(post_images[5]["alt"]).to eq("800x600 http")
      end

      it "crawls image data if a caption is present" do
        expect(post_images[6]["url"]).to eq("http://placehold.it/800x600")
        expect(post_images[6]["alt"]).to eq("800x600 http with caption")
      end

      it "crawls image data when 'alt' attr has special chars" do
        expect(post_images[7]["url"]).to eq("http://placehold.it/800x600")
        expect(post_images[7]["alt"]).to eq("800x600 ~¡!@\#$%^&*()_-+=[]{}\\|;:',.¿?/")
      end
    end
  end

  context "When page contains images in Markdown format"do
    describe "Crawler.crawl" do
      it "crawls png image data" do
        expect(page_images[0]["url"]).to eq("/media/images/800x600.png")
        expect(page_images[0]["alt"]).to eq("800x600 png")
      end

      it "crawls jpg image data" do
        expect(page_images[1]["url"]).to eq("/media/images/800x600.jpg")
        expect(page_images[1]["alt"]).to eq("800x600 jpg")
      end

      it "crawls gif image data" do
        expect(page_images[2]["url"]).to eq("/media/images/800x600.gif")
        expect(page_images[2]["alt"]).to eq("800x600 gif")
      end

      it "crawls image data if 'url' attr has an external URL" do
        expect(page_images[3]["url"]).to eq("http://placehold.it/800x600")
        expect(page_images[3]["alt"]).to eq("800x600 http")
      end

      it "doesn't crawl image data if image is excluded from crawling" do
        expect(page_images[9]).to be_nil
      end
    end
  end

  context "When page contains plain HTML images" do
    describe "Crawler.crawl" do
      it "crawls image data" do
        expect(page_images[4]["url"]).to eq("http://placehold.it/800x600")
        expect(page_images[4]["alt"]).to eq("800x600 http")
      end

      it "crawls image data if 'alt' attr is not present" do
        expect(page_images[8]["url"]).to eq("http://placehold.it/800x600")
        expect(page_images[8]["alt"]).to eq("")
      end
    end
  end

  context "When page contains images as liquid files" do
    describe "Crawler.crawl" do
      it "crawls image data" do
        expect(page_images[5]["url"]).to eq("http://placehold.it/800x600")
        expect(page_images[5]["alt"]).to eq("800x600 http")
      end

      it "crawls image data if a caption is present" do
        expect(page_images[6]["url"]).to eq("http://placehold.it/800x600")
        expect(page_images[6]["alt"]).to eq("800x600 http with caption")
      end

      it "crawls image data if 'alt' attr has special chars" do
        expect(page_images[7]["url"]).to eq("http://placehold.it/800x600")
        expect(page_images[7]["alt"]).to eq("800x600 ~¡!@\#$%^&*()_-+=[]{}\\|;:',.¿?/")
      end
    end
  end

  context "When post is rendered" do
    let(:output) { site.posts[0].output }

    it "image data is present in HTML output" do
      expect(output).to include("<meta name=\"image\" content=\"/media/images/800x600.png\">")
    end
  end

  context "When page is rendered" do
    let(:output) { site.pages[0].output }

    it "image data is present in HTML output" do
      expect(output).to include("<meta name=\"image\" content=\"/media/images/800x600.png\">")
    end
  end
end

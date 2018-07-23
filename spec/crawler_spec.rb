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

  before(:each) do
    site.process
  end

  describe "Crawler" do
    let(:post_images) { site.posts[0].data["images"] }
    let(:post_images_noalt) { site.posts[1].data["images"] }
    let(:page_images) { site.pages[0].data["images"] }

    it "crawls png image data from posts" do
      expect(post_images[0]["url"]).to eq("/media/images/800x600.png")
      expect(post_images[0]["alt"]).to eq("800x600 png")
    end

    it "crawls jpg image data from posts" do
      expect(post_images[1]["url"]).to eq("/media/images/800x600.jpg")
      expect(post_images[1]["alt"]).to eq("800x600 jpg")
    end

    it "crawls gif image data from posts" do
      expect(post_images[2]["url"]).to eq("/media/images/800x600.gif")
      expect(post_images[2]["alt"]).to eq("800x600 gif")
    end

    context "When post contains image with protocol specified" do
      it "crawls image data successfully" do
        expect(post_images[3]["url"]).to eq("http://placehold.it/800x600")
        expect(post_images[3]["alt"]).to eq("800x600 http")
      end
    end

    context "When post contains plain HTML image" do
      it "crawls image data successfully" do
        expect(post_images[4]["url"]).to eq("http://placehold.it/800x600")
        expect(post_images[4]["alt"]).to eq("800x600 http")
      end
    end

    context "When post contains image liquid file" do
      it "crawls image data successfully" do
        expect(post_images[5]["url"]).to eq("http://placehold.it/800x600")
        expect(post_images[5]["alt"]).to eq("800x600 http")
      end
    end

    context "When post contains image liquid file with caption" do
      it "crawls image data successfully" do
        expect(post_images[6]["url"]).to eq("http://placehold.it/800x600")
        expect(post_images[6]["alt"]).to eq("800x600 http with caption")
      end
    end

    context "When post contains image liquid file with special chars in 'alt' attribute" do
      it "crawls image data successfully" do
        expect(post_images[7]["url"]).to eq("http://placehold.it/800x600")
        expect(post_images[7]["alt"]).to eq("800x600 ~¡!@\#$%^&*()_-+=[]{}\\|;:',.¿?/")
      end
    end

    context "When post contains an excluded image" do
      it "doesn't crawl image data" do
        expect(post_images[8]).to be_nil
      end
    end

    context "When post contains image with no 'alt' attribute" do
      it "crawls image data successfully" do
        expect(post_images_noalt[0]["url"]).to eq("http://placehold.it/800x600")
        expect(post_images_noalt[0]["alt"]).to eq("")
      end
    end

    it "crawls png image data from pages" do
      expect(page_images[0]["url"]).to eq("/media/images/800x600.png")
      expect(page_images[0]["alt"]).to eq("800x600 png")
    end

    it "crawls jpg image data from pages" do
      expect(page_images[1]["url"]).to eq("/media/images/800x600.jpg")
      expect(page_images[1]["alt"]).to eq("800x600 jpg")
    end

    it "crawls gif image data from pages" do
      expect(page_images[2]["url"]).to eq("/media/images/800x600.gif")
      expect(page_images[2]["alt"]).to eq("800x600 gif")
    end

    context "When page contains image with protocol specified" do
      it "crawls image data successfully" do
        expect(page_images[3]["url"]).to eq("http://placehold.it/800x600")
        expect(page_images[3]["alt"]).to eq("800x600 http")
      end
    end

    context "When page contains plain HTML image" do
      it "crawls image data successfully" do
        expect(page_images[4]["url"]).to eq("http://placehold.it/800x600")
        expect(page_images[4]["alt"]).to eq("800x600 http")
      end
    end

    context "When page contains image liquid file" do
      it "crawls image data successfully" do
        expect(page_images[5]["url"]).to eq("http://placehold.it/800x600")
        expect(page_images[5]["alt"]).to eq("800x600 http")
      end
    end

    context "When page contains image liquid file with caption" do
      it "crawls image data successfully" do
        expect(page_images[6]["url"]).to eq("http://placehold.it/800x600")
        expect(page_images[6]["alt"]).to eq("800x600 http with caption")
      end
    end

    context "When page contains image liquid file with special chars in 'alt' attribute" do
      it "crawls image data successfully" do
        expect(page_images[7]["url"]).to eq("http://placehold.it/800x600")
        expect(page_images[7]["alt"]).to eq("800x600 ~¡!@\#$%^&*()_-+=[]{}\\|;:',.¿?/")
      end
    end

    context "When page contains an excluded image" do
      it "doesn't crawl image data" do
        expect(page_images[8]).to be_nil
      end
    end
  end

  describe "When post is rendered" do
    let(:output) { site.posts[0].output }

    it "image data is present in HTML output" do
      expect(output).to include("<meta name=\"image\" content=\"/media/images/800x600.png\">")
    end
  end

  describe "When page is rendered" do
    let(:output) { site.pages[0].output }

    it "image data is present in HTML output" do
      expect(output).to include("<meta name=\"image\" content=\"/media/images/800x600.png\">")
    end
  end
end

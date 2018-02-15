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

  context "For posts" do
    describe "Crawler" do
      let(:images) { site.posts[0].data["images"] }
      let(:images_no_alt) { site.posts[1].data["images"] }

      it "crawls png image data and stores it in metadata" do
        expect(images[0]["url"]).to eq("/media/images/800x600.png")
        expect(images[0]["alt"]).to eq("800x600 png")
      end

      it "crawls jpg image data and stores it in metadata" do
        expect(images[1]["url"]).to eq("/media/images/800x600.jpg")
        expect(images[1]["alt"]).to eq("800x600 jpg")
      end

      it "crawls gif image data and stores it in metadata" do
        expect(images[2]["url"]).to eq("/media/images/800x600.gif")
        expect(images[2]["alt"]).to eq("800x600 gif")
      end

      context "When image url contains protocol" do
        it "crawls image data and stores it in metadata" do
          expect(images[3]["url"]).to eq("http://placehold.it/800x600")
          expect(images[3]["alt"]).to eq("800x600 http")
        end
      end

      context "When plain HTML image is included" do
        it "crawls image data and stores it in metadata" do
          expect(images[4]["url"]).to eq("http://placehold.it/800x600")
          expect(images[4]["alt"]).to eq("800x600 http")
        end
      end

      context "When image liquid file is included" do
        it "crawls image data and stores it in metadata" do
          expect(images[5]["url"]).to eq("http://placehold.it/800x600")
          expect(images[5]["alt"]).to eq("800x600 http")
        end
      end

      context "When image with no 'alt' attribute is included" do
        it "crawls image data and stores it in metadata" do
          expect(images_no_alt[0]["url"]).to eq("http://placehold.it/800x600")
          expect(images_no_alt[0]["alt"]).to eq("")
        end
      end
    end
  end

  context "For pages" do
    let(:images) { site.pages[0].data["images"] }

    describe "Crawler" do
      it "crawls png image data and stores it in metadata" do
        expect(images[0]["url"]).to eq("/media/images/800x600.png")
        expect(images[0]["alt"]).to eq("800x600 png")
      end

      it "crawls jpg image data and stores it in metadata" do
        expect(images[1]["url"]).to eq("/media/images/800x600.jpg")
        expect(images[1]["alt"]).to eq("800x600 jpg")
      end

      it "crawls gif image data and stores it in metadata" do
        expect(images[2]["url"]).to eq("/media/images/800x600.gif")
        expect(images[2]["alt"]).to eq("800x600 gif")
      end

      context "When image url contains protocol" do
        it "crawls image data and stores it in metadata" do
          expect(images[3]["url"]).to eq("http://placehold.it/800x600")
          expect(images[3]["alt"]).to eq("800x600 http")
        end
      end

      context "When plain HTML image is included" do
        it "crawls image data and stores it in metadata" do
          expect(images[4]["url"]).to eq("http://placehold.it/800x600")
          expect(images[4]["alt"]).to eq("800x600 http")
        end
      end

      context "When image liquid file is included" do
        it "crawls image data and stores it in metadata" do
          expect(images[5]["url"]).to eq("http://placehold.it/800x600")
          expect(images[5]["alt"]).to eq("800x600 http")
        end
      end
    end
  end
end

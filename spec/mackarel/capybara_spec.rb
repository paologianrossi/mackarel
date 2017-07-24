require 'mackarel'
require 'capybara'
require 'capybara/dsl'
require 'support/test_app'

RSpec.describe Mackarel::Capybara do

  include Capybara::DSL
  include Mackarel

  Capybara.app = TestApp

  describe "#i_can_see" do
   it "finds content in page" do
     visit("/")                 #
     i_can_see("Hello world")
   end
  end

  describe "#i_am_taken_to" do
    it "checks the current path is right" do
      visit("/")
      click_on("A link")
      i_am_taken_to "/destination"
    end
  end

  describe "#i_find" do
    before { visit("/") }

    it "can find tags" do
      i_find("h1")
    end

    it "can find tags with text" do
      i_find("p", with_text: "Hello world")
    end

    it "can find links" do
      i_find(:link)
    end

    it "can find links with text" do
      i_find(:link, with_text: "A link")
    end

    it "can find links with pointing_to" do
      i_find(:link, pointing_to: "/destination")
    end

    it "can find links with pointing_to and text" do
      i_find(:link, with_text: "A link", pointing_to: "/destination")
    end

    it "can find pictures" do
      i_find(:image)
    end

    it "can find pictures with specific src" do
      i_find(:image, with_src: "some_pic.png")
    end

    it "can find pictures with specific alt text" do
      i_find(:image, with_text: "some alt text")
    end

    it "can find pictures with specific src and alt text" do
      i_find(:image, with_src: "some_pic.png", with_text: "some alt text")
    end
  end

  describe "#i_find_no" do
    before { visit("/") }

    it "can find missing tags" do
      i_find_no("h2")
    end

    it "can find tags with text" do
      i_find_no("p", with_text: "Foobar")
    end

    it "can find missing links" do
      visit("/destination")
      i_find_no(:link)
    end

    it "can find missing links with text" do
      i_find_no(:link, with_text: "A missing link")
    end

    it "can find missing links with pointing_to" do
      i_find_no(:link, pointing_to: "/destination_unknown")
    end

    it "can find missing links with either pointing_to and text" do
      i_find_no(:link, with_text: "A link", pointing_to: "/destination_unknown")
      i_find_no(:link, with_text: "A missing link", pointing_to: "/destination")
      i_find_no(:link, with_text: "A missing link", pointing_to: "/destination_unknown")
    end

    it "can find missing pictures" do
      visit("/destination")
      i_find_no(:image)
    end

    it "can find missing pictures with specific src" do
      i_find_no(:image, with_src: "missing_pic.png")
    end

    it "can find pictures with specific alt text" do
      i_find_no(:image, with_text: "some missing text")
    end

    it "can find missing pictures with either missing  src or alt text" do
      i_find_no(:image, with_src: "missing_pic.png", with_text: "some alt text")
      i_find_no(:image, with_src: "some_pic.png", with_text: "some missing text")
      i_find_no(:image, with_src: "missing_pic.png", with_text: "some missing text")
    end
  end

end

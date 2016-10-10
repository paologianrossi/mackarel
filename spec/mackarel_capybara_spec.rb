require 'mackarel'
require 'capybara'
require 'capybara/dsl'
require 'support/test_app'

RSpec.describe Mackarel do

  include Capybara::DSL
  include Mackarel
  Capybara.app = TestApp

  describe "#i_can_see" do
   it "finds content in page" do
     visit("/")
     i_can_see("Hello world")
   end
  end

  describe "#i_find" do
    before { visit("/") }
    it "can find tags" do
      i_find("h1")
    end
    it "can find tags with text" do
      i_find("h1", with_text: "This is a test")
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
end
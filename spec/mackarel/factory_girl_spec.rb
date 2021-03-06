require 'mackarel'
require 'factory_bot'

Model = Struct.new(:name) { def save!; end}
FactoryBot.define { factory(:model) { name "foobar" }}

RSpec.describe Mackarel::FactoryBot do

  include Mackarel::Core
  before(:all) { Mackarel.config { |c| c.factory = FactoryBot } }

  describe "#when_there_exists_a" do
    it "makes an instance object" do
      when_there_exists_a :model
      expect(@model).to be_a Model
    end

    it "uses defaults when there's no override" do
      when_there_exists_a :model
      expect(@model.name).to eq "foobar"
    end

    it "uses the passed overrides" do
      when_there_exists_a :model, name: "frobnic"
      expect(@model.name).to eq "frobnic"
    end

    it "uses a different name if passed 'called:'" do
      when_there_exists_a :model, called: "wayne", name: "john"
      expect(@wayne.name).to eq "john"
    end
  end

  describe "#when_there_exist" do
    it "makes a bunch of objects" do
      when_there_exist(5, :model)
      expect(@model_list.count).to eq 5
    end
    it "handles overrides" do
      when_there_exist(2, :model, name: "foobar")
      expect(@model_list.map(&:name)).to eq ["foobar", "foobar"]
    end
    it "uses a different name if passed 'called:'" do
      when_there_exist(2, :model, called: "foos", name: "foobar")
      expect(@foos.map(&:name)).to eq ["foobar", "foobar"]
    end
  end
end

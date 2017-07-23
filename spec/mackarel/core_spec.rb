require 'mackarel'

Value = Struct.new(:name) { def save!; end}

RSpec.describe Mackarel::Core do

  include Mackarel::Core
  before(:all) { Mackarel.config { |c| c.factory = Mackarel::BasicFactory } }

  describe "#when_i" do
    it "runs the block" do
      expect(when_i { 1 + 1 }).to eq 2
    end
  end

  describe "#when_there_exists_a" do
    it "makes an instance object" do
      when_there_exists_a Value
      expect(@value).to be_a Value
    end

    it "uses the passed overrides" do
      when_there_exists_a Value, "frobnic"
      expect(@value.name).to eq "frobnic"
    end

    it "uses a different name if passed 'called:'" do
      when_there_exists_a Value,  "john", called: "wayne"
      expect(@wayne.name).to eq "john"
    end
  end

  describe "#when_there_exist" do
    it "makes a bunch of objects" do
      when_there_exist(5, Value)
      expect(@value_list.count).to eq 5
    end
    it "handles overrides" do
      when_there_exist(2, Value, "foobar")
      expect(@value_list.map(&:name)).to eq ["foobar", "foobar"]
    end
    it "uses a different name if passed 'called:'" do
      when_there_exist(2, Value, "foobar", called: "foos")
      expect(@foos.map(&:name)).to eq ["foobar", "foobar"]
    end
  end
end

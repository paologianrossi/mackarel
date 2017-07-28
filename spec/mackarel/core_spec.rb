require 'mackarel'

Value = Struct.new(:name)

RSpec.describe Mackarel::Core do

  include Mackarel::Core
  before(:all) { Mackarel.config { |c| c.factory = Mackarel::BasicFactory } }

  describe "#when_i" do
    it "runs the block" do
      expect(when_i { 1 + 1 }).to eq 2
    end
  end

  describe "#create_a" do
    it "makes an instance object" do
      expect { create_a(Value) }.to change { self.instance_variables }
                                    .by([:"@value"])
      expect(@value).to be_a Value
    end

    it "returns the created object" do
      value = create_a(Value)
      expect(value).to be_a Value
    end

    it "uses the passed overrides" do
      create_a Value, "frobnic"
      expect(@value.name).to eq "frobnic"
    end

    context "when called: is something" do
      it "uses a different instance variable name" do
        expect { create_a(Value, called: "wayne") }
          .to change { self.instance_variables }.by([:"@wayne"])

        expect(@wayne).to be_a Value
      end
    end

    context "when called: is falsey" do
      it "does not create an instance variable" do
        expect { create_a(Value, called: nil) }
          .not_to change { self.instance_variables.count }
      end
    end
  end

  describe "#create_a_list_of" do
    it "makes a list of objects" do
      values = create_a_list_of(5, Value)
      expect(values.count).to eq 5
    end

    it "creates a _list instance variable" do
      expect { create_a_list_of(5, Value) }
        .to change { self.instance_variables }.by([:"@value_list"])
    end

    it "passes arguments to the factory" do
      values = create_a_list_of(2, Value, "foobar")
      expect(values.map(&:name)).to eq ["foobar", "foobar"]
    end

    context "when called: is set" do
      it "uses a different name for the instance variable" do
        expect { create_a_list_of(2, Value, called: "foobars") }.to change { self.instance_variables }.by([:"@foobars"])
        expect(@foobars.map(&:class)).to eq [Value, Value]
      end
    end

    context "when called: is falsey" do
      it "does not create an instance variable" do
        expect { create_a_list_of(5, Value, called: nil) }
          .not_to change { self.instance_variables.count }
      end
    end
  end
end

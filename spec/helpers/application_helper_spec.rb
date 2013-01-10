describe ApplicationHelper do
  describe "#title" do
    context "when there is no product" do
      it "returns tinysale as the title" do
        title(nil).should == "tinysale"
      end
    end
    context "when there is a product present" do
      it "returns the product title" do
        product = FactoryGirl.build :product
        title(product).should == "My Book"
      end
    end
  end

  describe "#image_for" do
    context "when the user has NOT uploaded an avatar" do
      it "returns an image tag with the gravatar url" do
        user = FactoryGirl.build :user
        image_for(user).should =~ /https:\/\/secure.gravatar.com\/avatar/
      end
    end
    context "when the user uploaded an avatar" do
      it "returns the local image url" do
        user = FactoryGirl.build :user, avatar: File.new(Rails.root + 'spec/factories/images/rails.png')
        image_for(user).should =~ /\/system\/users\/avatars\/\/original\/rails.png?/
      end
    end
  end

  context "star rating" do
    before do
      @rateable = FactoryGirl.build :comment, id: 24
    end
    describe "#star_button" do
      it "correctly creates a star" do
        star_button(@rateable, 3, @rateable.rating).should == "<input class=\"star {split:1}\" disabled=\"disabled\" id=\"star3_trek24_\" name=\"star3[trek24]\" type=\"radio\" />"
      end
    end

    describe "#star_button_rate" do
      it "correctly creates a rateable star" do
        star_button_rate(@rateable, 4, false).should == "<input class=\"star\" id=\"rating_24_4\" name=\"rating[24]\" type=\"radio\" value=\"4\" />"
      end
    end

    describe "#star_split" do
      it "correctly calculates the split" do
        star_split(3.25).should == 4
        star_split(4.33).should == 3
        star_split(2.5).should == 2
        star_split(@rateable.rating).should == 1
      end
    end
  end
end
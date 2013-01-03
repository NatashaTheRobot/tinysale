#def title(product)
#  product.present? ? product.title : 'tinysale'
#end

describe ApplicationHelper do
  describe "title" do
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
end
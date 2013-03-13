require 'spec_helper'

describe Transaction do
  it { should belong_to :product }

  #describe "after_save" do
  #  it "sends the product emails" do
  #
  #  end
  #end
end

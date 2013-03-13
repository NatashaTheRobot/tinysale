require 'spec_helper'

describe Lead do
  it { should have_many :comments }
  it { should validate_presence_of :email }
  it { should validate_uniqueness_of :email }
  it { should validate_format_of(:email).with('natasha@natashatherobot.com') }
  it { should_not validate_format_of(:email).with('natasha') }

  describe ".build_from" do
    it "should create a lead from email" do
      lead = Lead.build_from('natasha@natashatherobot.com')
      lead.email.should == 'natasha@natashatherobot.com'
    end
  end

  context "before_create" do
    before do
      @lead = Lead.build_from('nmurashev@gmail.com')
      @lead.save
    end
    it "generates a lead token" do
      @lead.token.should_not be_nil
    end
    it "gets a username from gravatar" do
      @lead.username.should eq 'natasham25'
    end
  end

end

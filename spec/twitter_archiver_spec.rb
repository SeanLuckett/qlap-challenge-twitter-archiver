require 'spec_helper'

describe TwitterArchiver do
  let(:arg) { "@SomeName" }
  subject { TwitterArchiver.new(arg) }

  its(:passed_in_arg) { should_not be_nil } 

  describe "When the argument starts with @, it:" do
    before do
      twitter_user = double()
      twitter_user.stub(:attrs) {{ 
        :id => 199853758,
        :name => "Some Name",
        :screen_name => "SomeName",
        :location => "Anytown, WA"
      }}
      Twitter.stub(:user) { twitter_user }
    end

    it "grabs user data from twitter" do
      returned_data = subject.get_twitter_data
      returned_data.attrs[:location].should == "Anytown, WA"
    end

    it "writes data to a file" do
      file_name = subject.save_user_data
      Dir.glob(file_name).should be_true
    end

  end

  describe "When the argument starts with #, it:" do
    let(:arg) { "#StoryBehindMyScar" }
    subject { TwitterArchiver.new(arg) }

    before do
      twitter_search = double()
      twitter_search.stub(:attrs) {{ :results => "Jumble of convoluted shit" }}
      Twitter.stub(:search) { twitter_search }
    end

    it "searches Twitter for results" do
      search_data = subject.get_twitter_data
      search_data.attrs[:results].should include("Jumble")
    end

    it "writes data to a file" do
      file_name = subject.save_user_data
      Dir.glob(file_name).should be_true
    end
  end
end

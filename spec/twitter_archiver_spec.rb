require 'spec_helper'

describe TwitterArchiver do
  context 'when the argument starts with @' do
    before :each do
      twitter_user = double()
      allow(twitter_user).to receive(:attrs) {{
        :screen_name => 'SomeName',
        :location => 'Anytown, WA'
      }}

      allow(Twitter).to receive(:user) { twitter_user }
    end

    it 'grabs user data from twitter' do
      returned_data = TwitterArchiver.new('@SomeName').get_twitter_data
      expect(returned_data.attrs[:location]).to eq 'Anytown, WA'
    end

    it 'writes data to a file' do
      file_name = TwitterArchiver.new('@SomeName').save_user_data
      expect(Dir.glob(file_name)).to include 'SomeName.txt'
    end

  end

  context 'when the argument starts with #' do
    before do
      twitter_search = double()
      allow(twitter_search).to receive(:attrs) {{ :results => 'This is a tweet.' }}
      allow(Twitter).to receive(:search) { twitter_search }
    end

    it 'searches Twitter for results' do
      search_data = TwitterArchiver.new('#StoryBehindMyScar').get_twitter_data
      expect(search_data.attrs[:results]).to include 'This is a tweet.'
    end

    it 'writes data to a file' do
      file_name = TwitterArchiver.new('#StoryBehindMyScar').save_user_data
      expect(Dir.glob(file_name)).to include 'StoryBehindMyScar.txt'
    end
  end
end

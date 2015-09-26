$LOAD_PATH << File.expand_path('../lib', __FILE__)
require 'twitter_archiver'

RSpec.configure do |config|
  config.after(:all) do
    FileUtils.rm(Dir['SomeName.txt', 'StoryBehindMyScar.txt'])
  end
end

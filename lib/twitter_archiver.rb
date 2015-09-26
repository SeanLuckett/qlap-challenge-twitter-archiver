require 'rubygems'
require 'twitter'

class TwitterArchiver

  def initialize(data)
    @data = data
    @twitter_data = get_twitter_data
  end

  def get_twitter_data
    if @data.start_with?("#")
      Twitter.search(@data)
    else
      Twitter.user(@data)
    end
  end

  def save_user_data
    file_name = @data.start_with?("#") ? "#{@data.slice(1..-1)}.txt" : "#{@twitter_data.attrs[:screen_name]}.txt"
    File.open(file_name, "w") do |file|
      @twitter_data.attrs.each_pair do |key, val|
        file.puts "#{key}: #{val}"
      end
    end
    file_name
  end

  protected
  attr_reader :data
end

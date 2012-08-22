require 'rubygems'
require 'twitter'

class TwitterArchiver
attr_reader :passed_in_arg

  def initialize(arg)
    @passed_in_arg = arg
    @grabbed_data = get_twitter_data
  end

  def get_twitter_data
    if @passed_in_arg.start_with?("#")
      Twitter.search(@passed_in_arg)
    else
      Twitter.user(@passed_in_arg)
    end
  end

  def save_user_data
    file_name = @passed_in_arg.start_with?("#") ? "#{@passed_in_arg.slice(1..-1)}.txt" : "#{@grabbed_data.attrs[:screen_name]}.txt"
    File.open(file_name, "w") do |file|
      @grabbed_data.attrs.each_pair do |key, val|
        file.puts "#{key}: #{val}"
      end
    end
    file_name
  end
end

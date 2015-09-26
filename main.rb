require 'net/https'
require 'oauth'
require './key'

class TwitterRequest
  TWITTER_HOST = 'https://api.twitter.com/'

  def prepare_access_token(oauth_token, oauth_token_secret)
    consumer = OAuth::Consumer.new(
        TWITTER_CONSUMER_KEY,
        TWITTER_CONSUMER_SECRET,
        {
            :site => TWITTER_HOST,
            :scheme => :header
        }
    )
    OAuth::AccessToken.new(consumer, oauth_token, oauth_token_secret)
  end

  def request (twitter_name)
    access_token = prepare_access_token(
        TWITTER_ACCESS_TOKEN,
        TWITTER_ACCESS_TOKEN_SECRET
    )
    access_token.request(
        :get,
        TWITTER_HOST + '1.1/users/show.json?screen_name=' + twitter_name,
    )
  end
end

class FindShortTwitterId
  def main
    get_request = TwitterRequest.new

    # get first digit and amount from argv
    digit_from, count = validate_argv
    range = 1..count

    range.each { |num|
      twitter_name = generate_name_with_digit digit_from + num - 1
      if get_request.request(twitter_name).instance_of? Net::HTTPNotFound
        puts 'NOT USED : ' + twitter_name + "\n"
      else
        puts 'USED : ' + twitter_name + "\n"
      end
    }
  end

  private

  def validate_argv
    from = ARGV[0].to_i
    count = ARGV[1].to_i

    # Twitter api limitation (180 queries / 15 min)
    count = [180, count].min

    [from, count]
  end

  N_CHAR = 37

  # each digit corresponds to each name
  # e.g.
  # 0 : 'a', 1 : 'b', ... , 35 : '9', 36 : '_'
  # 37 : 'aa', 38 : 'ab', ... , 73 : 'a_'
  # 1406 : 'aaa', ...
  def generate_name_with_digit (digit)
    char_array = ('a'..'z').to_a + ('0'..'9').to_a + ['_'] # char_array.length is 37

    quotient = digit
    queue = []
    while true do
      queue.push quotient % N_CHAR
      quotient = (quotient / N_CHAR).round - 1
      if quotient <= -1
        break
      end
    end

    name = ''
    while queue.any? do
      name = name + char_array[queue.pop]
    end
    name
  end
end

klass = FindShortTwitterId.new
klass.main

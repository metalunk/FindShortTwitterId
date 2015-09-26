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

# TODO
class FindShortTwitterId
  def main
    get_request = TwitterRequest.new
    twitter_name = generate_name
    if get_request.request(twitter_name).instance_of? Net::HTTPNotFound
      p twitter_name + ' is not used'
    end
  end

  def generate_name
    'metal_unk'
  end
end

klass = FindShortTwitterId.new
klass.main

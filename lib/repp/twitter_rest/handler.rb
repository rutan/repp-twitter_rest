module Repp
  module TwitterRest
    class Handler
      class << self
        def run(app, _options = {})
          yield self if block_given?

          @client = create_client
          handler = MessageHandler.new(@client, app.new)
          handler.handle
        end

        def stop!
          @client.stop!
        end

        private

        def create_client
          Twitter::REST::Client.new do |config|
            config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
            config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
            config.access_token = ENV['TWITTER_ACCESS_TOKEN']
            config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
          end
        end
      end
    end
  end
end

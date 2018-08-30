module Repp
  module TwitterRest
    class MessageHandler
      attr_reader :client, :app

      def initialize(client, app)
        @client = client
        @app = app
      end

      def handle
        loop do
          begin
            (fetch_timeline + fetch_mention).uniq.each do |tweet|
              on_tweet(tweet)
            end
          rescue StandardError => e
            puts e.inspect
          end

          sleep 90
        end
      end

      private

      def fetch_timeline
        tweets = client.home_timeline(count: 200)
        @last_timeline_id ||= tweets.first.id

        tweets.select { |tweet| tweet.id > @last_timeline_id }
      end

      def fetch_mention
        tweets = client.mentions_timeline(count: 200)
        @last_mention_id ||= tweets.first.id

        tweets.select { |tweet| tweet.id > @last_mention_id }
      end

      def on_tweet(tweet)
        puts tweet.inspect # debug

        receive = Receive.build(tweet)
        res = app.call(receive)
        text = res.first.to_s
        return if text.empty?

        client.update(
          text,
          in_reply_to_status_id: tweet.id
        )
      end
    end
  end
end

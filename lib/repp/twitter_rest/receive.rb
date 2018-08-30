module Repp
  module TwitterRest
    class Receive < Repp::Event::Receive
      interface :raw

      def user
        raw.user
      end

      class << self
        def build(tweet)
          new(
            raw: tweet,
            body: tweet.full_text,
            reply_to: tweet.user.screen_name
          )
        end
      end
    end
  end
end

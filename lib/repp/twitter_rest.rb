require 'repp'
require 'twitter'

require 'repp/twitter_rest/version'
require 'repp/twitter_rest/receive'
require 'repp/twitter_rest/message_handler'
require 'repp/twitter_rest/handler'

Repp::Handler.register 'twitter_rest', 'Repp::TwitterRest::Handler'

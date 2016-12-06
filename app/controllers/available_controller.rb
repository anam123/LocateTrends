class AvailableController < ApplicationController
    def index
        client = Twitter::REST::Client.new do |config|
            config.consumer_key    = "ZOcGJVl89eSWNp42zTgPQ7abB"
            config.consumer_secret = "oBlXgEo6x4VBECPWGCvSZ49kgIedcmoRxOxyTUt2FWTXRQKTE3"
        end
        @available = client.trends_available(options = {})
        @available.shift
    end
end

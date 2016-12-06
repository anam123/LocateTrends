class ArticlesController < ApplicationController
    def new
        client = Twitter::REST::Client.new do |config|
            config.consumer_key    = "ZOcGJVl89eSWNp42zTgPQ7abB"
            config.consumer_secret = "oBlXgEo6x4VBECPWGCvSZ49kgIedcmoRxOxyTUt2FWTXRQKTE3"
        end
        #@locid = params[:param1]
        latitude = params[:param1]
        longitude = params[:param2]
        @closest = client.trends_closest(options = {:lat => latitude, :long => longitude})
        @available = client.trends_available(options = {})
        @locid1 = @closest[0].woeid
        @name = @closest[0].name
        #@available.each do |t|
        
        #ids = Array.new()
        #@available.each do |t|
            #ids.push(t.woeid)
        #end
        #puts ids
        #@trends = Array.new()
        #i = 0
        #ids.each do |t|
            #@trends.push(client.trends(id = t, opions = {}))
            #i = i + 1
            #if(i > 0)
                #break
            #end
        #end
        
        @trends = client.trends(id = @locid1, opions = {})
        #@trends1 = client.trends(id = @available[0].woeid, options = {})
        
        client_stream = Twitter::Streaming::Client.new do |config|
            config.consumer_key        = "ZOcGJVl89eSWNp42zTgPQ7abB"
            config.consumer_secret     = "oBlXgEo6x4VBECPWGCvSZ49kgIedcmoRxOxyTUt2FWTXRQKTE3"
            config.access_token        = "805375125071593473-gI3BrOuzVPzmzM1cvTRryAsUpXWHIrJ"
            config.access_token_secret = "khOpsQWW0auasRJuHHknfZKNSWBxnjXhrUh3mmrP95X3J"
        end
        
        topics = []
        @trends.each do |t|
            topics.push(t.name.to_s)
        end
        
        
        puts topics
        topics1 = ["coffee", "tea"]
        topics2 = [topics[0].to_s]
        topics3 = []
        j = 0
        for i in 0..5
            topics3.push(topics[i].to_s) 
            j = j + 1
            if j > 10
                break
            end
        end
        puts topics3
        place = ["-122.75","36.8","-121.75","37.8"]
        longitude1 = longitude.to_i+5
        latitude1 = latitude.to_i+5
        filterbound = [longitude.to_s,latitude.to_s,longitude1.to_s,latitude1.to_s]
        #puts place
        filterwords = ""
        #@trends.each do |t|
            #filterwords += filterwords + t.name.to_s + ","
        #end
        puts filterbound
        #puts filterwords
        i = 0
        @tweetstream = []
        client_stream.filter(locations: filterbound.join(","), track: topics3.join(",")) do |tweet|
            @tweetstream.push(tweet.text)
            i = i + 1
            if(i > 20)
                break
            end
        end
        @alltrends = []
        puts @tweetstream
        
    end
end

class ApplicationController < Sinatra::Base

set :views, Proc.new { File.join(root, "../views/")}

configure do
  enable :sessions
  set :session_secret, "secret"
end

get '/' do
  erb :index
end


helpers do
		def logged_in?
			!!session[:id]
		end

		def current_user
			@current_user ||= User.find(session[:id])
		end

    def logout!
      session.clear
    end

    def get_page
      @event = Event.new
      @doc ||= scrape
    end

    def scrape
      # require 'open-uri'
      html_doc = open("https://www.amnh.org/calendar?facetsearch=1")
      nokogiri_doc = Nokogiri::HTML(html_doc)
      # binding.pry
    end

    def get_events
      get_page.css(".mod.event")
    end

    def make_events
      # binding.pry
      Event.connection
      get_events.each do |post|
        # @event = Event.new
        @event.type = post.css("p.category").text
        @event.name = post.css("a").text.strip
        @event.date = post.css("p.date").text
        @event.website = post.css("a").first["href"]
        text = post.css("p").text
        @event.description = text.to_s.gsub(/#{event.date}/,"").gsub(/#{event.type}/,"").gsub(" Members Only","").gsub(" Sold Out","").gsub(" Free With Museum Admission","").gsub("â"," ")
        @event.save
      end
      Event.all
    end

	end
end

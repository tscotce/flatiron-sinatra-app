# require './config/environment'

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
      @@doc ||= scrape
    end

    def scrape
      Nokogiri::HTML(open("https://www.amnh.org/calendar?facetsearch=1"))
    end

    def get_events
      self.get_page.css(".mod.event")
    end

    def make_events
      get_events.each do |post|
        @event = Event.new
        # @@all << event
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

    # def sort_events
    #   Event.make_events
    #   Event.all.sort_by! {|event| event.type}
    # end
    #
    # def make_types
    #   self.sort_events.uniq {|event| event.type}
    # end
    #
    # def print_types
    #   Event.make_types.each.with_index(1) do |event, i|
    #     puts "#{i}. #{event.type}"
    #   end
    # end
    #
    # def list_types
    #   # puts "Here are types of upcoming events at the American Museum of Natural History (AMNH):"
    #   @event_types = self.print_types
    #   # puts "Enter the number corresponding to the type of event you'd like more information on or type 'exit':"
    # end
	end
end

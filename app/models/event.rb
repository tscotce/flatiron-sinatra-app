class Event < ActiveRecord::Base
  belongs_to :user

  attr_accessor :event, :name, :type, :date, :description, :url_text, :url, :time, :location, :tickets, :detailed_description

  @@all = []

  def self.all
    @@all
  end

  def self.get_events
    Scraper.get_page.css(".mod.event")
  end

  def self.make_events
    self.get_events.each do |post|
      event = Event.new
      @@all << event
      event.type = post.css("p.category").text
      event.name = post.css("a").text.strip
      event.date = post.css("p.date").text
      text = post.css("p").text
      event.description = text.to_s.gsub(/#{event.date}/,"").gsub(/#{event.type}/,"").gsub(" Members Only","").gsub(" Sold Out","").gsub(" Free With Museum Admission","").gsub("â"," ")
      event.website = post.css("a").first["href"]
    end
    self.all
  end

  def self.sort_events
    self.make_events
    self.all.sort_by! {|event| event.type}
  end

  def self.make_types
    self.sort_events.uniq {|event| event.type}
  end

  def print_types
    Event.make_types.each.with_index(1) do |event, i|
      puts "#{i}. #{event.type}"
    end
  end

  def list_types
    # puts "Here are types of upcoming events at the American Museum of Natural History (AMNH):"
    @event_types = print_types
    # puts "Enter the number corresponding to the type of event you'd like more information on or type 'exit':"
  end

  def list_events(type)
    @events = Event.sort_events.select {|event| event.type == type}
    @events.uniq {|event| event.name}
  end

  def menu
    input = nil
    while input != "exit"
      input = gets.strip.downcase
      if input.to_i.between?(1, Event.make_types.length)
        type = @event_types[input.to_i - 1].type
        list_events(type).each do |event|
          puts "#{event.date} - #{event.name}:"
          puts "#{event.description}"
          puts "For additional information and to purchase tickets, go to https://www.amnh.org/#{event.url}"
          puts
        end
        puts "Type 'list' to see available types of events again or type 'exit':"
      elsif input == "list"
        list_types
        "Enter the number corresponding to the type of event you'd like more information on or type 'exit':"
      else puts "Type 'list' to see available types of events again or type 'exit':"
      end
    end
  end

end

class Scraper < ActiveRecord::Base
  def self.get_page
    @@doc ||= scrape
  end

  def self.scrape
    Nokogiri::HTML(open("https://www.amnh.org/calendar?facetsearch=1"))
  end
end

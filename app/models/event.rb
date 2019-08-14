class Event < ActiveRecord::Base
  belongs_to :user

  # attr_accessor :event, :name, :description, :website, :type, :date

end

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  require 'rubygems'
  require 'twilio-ruby'
end

#this is a "wrapper (stub)" giving the impression to "TODO project"
#but for the Catalog project this class actually works as model

class Category < ActiveRecord::Base

  #this is stub written for TODO project
  def self.get_all_from_service
    #connect over HTTP and get all the categories and return a HASH from here

    response = HTTParty.get(ENV['CATEGORY_LOOKUP_SERVICE'], {timeout: 15})
    JSON.parse(response.body)
  end
end

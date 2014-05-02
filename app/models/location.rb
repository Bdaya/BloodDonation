class Location
  include Mongoid::Document
  include Mongoid::Timestamps
  include Geocoder::Model::Mongoid

   Location
  field :location, type: Array  # [latitude:float, longitude:float]
  field :address, type: String
  
  reverse_geocoded_by :location
  fter_validation :reverse_geocode  # auto-fetch ad

  belongs_to :user_location, class_name: 'User' , inverse_of: :locations

end

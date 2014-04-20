class Donor
  include Mongoid::Document
  field :name, type: String
  field :age, type: Integer
  field :blood_type, type: String
  field :email, type: String
  field :password, type: String
  field :phone_number, type: Integer
  field :latitude, type: String
  field :longitude, type: String
end

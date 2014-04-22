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

  #  how many times this user REALLY donated through the system
  field :no_of_donates, type: Integer, default: 0

  #  this is to denote trophies level (say 2 trophies = level 1)
  field :no_of_trophies, type: Integer, default: 0  
  #  and this one is to denote the type of the tropy (say level 2 = silver star)
  field :trophies_level, type: Integer, default: 0  
  
  #  is_available is for the user to choose whether to toggle his availibilty button or NOT
  field :is_available, type: Boolean, default: true
  #  here,, a user can only donate once in every 3 months (taqreeban)
  field :can_donate, type: Boolean, default: true
end

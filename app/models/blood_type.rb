class BloodType
  include Mongoid::Document

  field :type, type: String
    validates_uniqueness_of :type, :message => "Blood type already exists"
  has_many :users
  has_many :requests
  
end
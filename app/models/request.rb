class Request
  include Mongoid::Document
  
  field :patient_name, type: String
  validates_presence_of :patient_name, :message=> "Must enter the patient name!"

  field :contact_name, type: String
  validates_presence_of :contact_name, :message=> "Must enter the contact name!"
  
  field :contact_phone, type: String
  validates_presence_of :contact_phone, :message=> "Must enter your Mobile number!"
  validates_length_of :contact_phone, minimum: 11, maximum: 11, :message=> "Mobile number must be of length 11.."
  validates_numericality_of :contact_phone, :message=> "Must enter mobile number in numerical form only!"
  validates_uniqueness_of :contact_phone, :message=> "This mobile number is already associated with another user!"
  
  field :national_id, type: String
  validates_presence_of :national_id, :message=> "Must enter your ID!"
  validates_length_of :national_id, minimum: 14, maximum: 14, :message=> "ID must be of length 14.."
  validates_numericality_of :national_id, :message=> "Must enter ID in numerical form only!"
  validates_uniqueness_of :national_id, :message=> "This ID is already associated with another user!"

  field :blood_type, type: String
  
  field :req_type, type: String
  
  field :due_date, type: Date
  #validates_presence_of :due_date, :message=> "Must enter the due date!"

  field :hospital_name, type: String
  validates_presence_of :hospital_name, :message=> "Must enter the hospital name!"

  field :hospital_address, type: String

  field :hospital_phone, type: String
  validates_presence_of :hospital_phone, :message=> "Must enter the hospital phone number!"

  field :email, type: String
  validates_presence_of :email, :message=> "Must enter your email!"

  field :blood_bags, type: Integer
  field :number_of_replies, type: Integer,default: 0

  field :reply_is_confirmed, type: Boolean, default: false


  has_many :replies, class_name: 'Reply' , inverse_of: :request

  
end
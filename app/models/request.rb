class Request
  include Mongoid::Document
  field :patient_name, type: String
  field :contact_name, type: String
  field :national_id, type: String
  field :blood_type, type: String
  field :req_type, type: String
  field :due_date, type: Date
  field :hospital_adress, type: String
  field :hospital_phone, type: String
  field :email, type: String
  field :blood_bags, type: Integer
end

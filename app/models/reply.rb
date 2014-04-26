class Reply
  include Mongoid::Document
  
  field :is_confirmed, type: Boolean, default: false
  field :requester_report , type: String
  field :donor_report , type: String

  
  belongs_to :user, clas_name: 'User' , inverse_of: :replies
  belongs_to :request, clas_name: 'Request' , inverse_of: :replies
  
end

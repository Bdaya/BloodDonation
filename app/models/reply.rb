class Reply
  include Mongoid::Document
  include Mongoid::Timestamps

  field :is_confirmed, type: Boolean, default: false
  field :requester_report , type: String
  field :donor_report , type: String
  field :reply_is_confirmed, type: Boolean, default: false


  
  belongs_to :user, class_name: 'User' , inverse_of: :replies
  belongs_to :request, class_name: 'Request' , inverse_of: :replies
  
end

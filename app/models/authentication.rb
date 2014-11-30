class Authentication
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

 belongs_to :user
    field :user_id, :type => String
    field :provider, :type => String
    field :uid, :type => String
    field :token, :type => String
    field :secret_token, :type => String
 def self.find_by_provider_and_uid(provider, uid)
  where(provider: provider, uid: uid).first
  end

 
end

class SocialProvider
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Attributes::Dynamic

  #Relations

  belongs_to :user


  field :pid, type: String
  field :token, type: String
  field :refresh_token, type: String
  field :secret, type: String
  field :expires_at, type: Time
  field :provider_type, type: String
  field :user_id, type: Integer
  field :url, type: String
  field :email, type: String 
  #Scopes

  def self.facebook 
    where(provider_type: :facebook)
  end

  def self.twitter
    where(provider_type: :twitter)
  end

  def self.google_oauth2
    where(provider_type: :google_oauth2)
  end


  def self.find_for_oauth(auth, provider_type)
    social_provider = self.where(pid: auth[:uid].to_s, provider_type: provider_type).first
    if social_provider.nil?
      user = User.find_by(email: auth[:info][:email])
      if user.nil?
        social_provider = SocialProvider.new
      else
        social_provider = user.social_providers.where(provider_type: provider_type).first
      end
    end
    social_provider.update_from_oauth(auth, provider_type)
    social_provider
  end

  def update_from_oauth(auth, provider_type)
    self.email = auth[:info][:email]
    self.pid = auth[:uid]
    self.provider_type = provider_type
    credentials = auth[:credentials]
    case provider_type
    when :twitter
      self.token = credentials[:token]
      self.secret = credentials[:secret]
      self.url = auth[:info][:urls][:Twitter]
    when :facebook
      self.token = credentials[:token]
      self.url = auth[:extra][:raw_info][:link]
    when :google_oauth2
      self.token = credentials[:token]
      self.refresh_token = credentials[:refresh_token]
      self.url = auth[:extra][:raw_info][:profile]
   end
  end
end


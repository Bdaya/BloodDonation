class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Attributes::Dynamic

  GENDERS = ['male', 'female']
  BETWEEN_DONATIONS = 90

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  field :email, type: String, default: ""
  field :encrypted_password, type: String, default: ""

  ## Recoverable
  field :reset_password_token, type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count, type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at, type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip, type: String

  ######### Special Attributes #########
  field :gender, type: String
    validates_inclusion_of :gender, :in => GENDERS

  field :name, type: String
    validates_presence_of :name, :message=> "Must enter your name!"

  field :phone, type: String
    validates_presence_of :phone, :message=> "Must enter your Mobile number!"
    validates_length_of :phone, minimum: 11, maximum: 11, :message=> "Mobile number must be of length 11.."
    validates_numericality_of :phone, :message=> "Must enter mobile number in numerical form only!"
    validates_uniqueness_of :phone, :message=> "This mobile number is already associated with another user!"

  field :age , type: Integer
    validates_presence_of :age, :message=> "Must enter your Age!"

  field :national_id , type: String
    validates_presence_of :national_id, :message=> "Must enter your ID!"

  field :paused, type: Boolean, default: false # indicator for user pausing or not
  field :can_donated, type: Boolean, default: true

  field :last_donated, type: DateTime

  belongs_to :blood_type
  has_one :location, as: :locatable
    validates_presence_of :location, :message=> "Must choose hospital's location!"
 

  has_many :requests
  has_many :replies
  has_many :social_providers


  ##### Methods #####
  
  def can_donate?
    return true unless last_donated

    ## TO FIX
    ## gives out "expected numeric" error
    if (DateTime.now - last_donated).to_i > BETWEEN_DONATIONS
      true
    else
      false
    end
  end

  def confirmed_donations
    replies.where(confirmed: true)
  end

  def no_of_confirmed_donations
    confirmed_donations.count
  end

  def reports
    replies.select{ |reply| reply.report != nil }.map(&:reports)
  end

  def uncompleted_donations
    replies.where(confirmed: false)
  end

  def no_of_uncompleted_donations
    uncompleted_donations.count
  end

  def cancelled_donations
    replies.where(cancelled: true)
  end

  def no_of_cancelled_donations
    cancelled_donations.count
  end

  def find_matching_requests_arround(distance_in_km = 15)
    distance_in_miles = distance_in_km * 1.60934
    current_place = self.location
    near_requests = Request.active.select{ |r| r.blood_type == blood_type}.select{ |r| Geocoder::Calculations.distance_between(current_place.coordinates, r.coordinates) <= distance_in_miles }
    near_requests
  end

    # update from OAuth
 
   def update_from_oauth(auth, provider_type)
     self.email = auth[:info][:email] if self.email.blank?
       case provider_type
        when :twitter
           name = auth[:info][:name].split(' ')
           self.first_name ||= name[0]
           self.last_name ||= name[1]
           
        when :facebook
           self.name ||= auth[:info][:first_name] + auth[:info][:last_name]
        when :google_oauth2
           name = auth[:info][:name].split(' ')
           self.first_name ||= name[0]
           self.last_name ||= name[1] 
        end
     end

end

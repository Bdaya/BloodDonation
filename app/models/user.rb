class User
  include Mongoid::Document
  include Mongoid::Timestamps
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :phone,:ID, :email, :password, :password_confirmation, :remember_me , :blood_type , :age

  ## Database authenticatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""

  ## Recoverable
  field :reset_password_token,   type: String 
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  field :name, type: String
  validates_presence_of :name, :message=> "Must enter your name!"

  field :phone, type: String
  validates_presence_of :phone, :message=> "Must enter your Mobile number!"
  validates_length_of :phone, minimum: 11, maximum: 11, :message=> "Mobile number must be of length 11.."
  validates_numericality_of :phone, :message=> "Must enter mobile number in numerical form only!"
  validates_uniqueness_of :phone, :message=> "This mobile number is already associated with another user!"
  
  field :blood_type, type: String
  field :age , type: Integer
  validates_presence_of :phone, :message=> "Must enter your Age!"
  field :ID , type: String
  validates_presence_of :ID, :message=> "Must enter your ID!"
  field :state , type: Boolean , default: true
 
  #  how many times this user REALLY donated through the system
  field :no_of_donates, type: Integer, default: 0

  #  this is to denote trophies level (say 2 trophies = level 1)
  field :no_of_trophies, type: Integer, default: 0  
  #  and this one is to denote the type of the tropy (say level 2 = silver star)
  field :trophies_level, type: Integer, default: 0  
  
  #  is_available is for the user to choose whether to toggle his availibilty button or NOT
  field :is_available, type: Boolean, default: true
  #  here,, a user can only donate once in every 3 months (taqreeban)
  ## Confirmable
  # field :confirmation_token,   type: String
  # field :confirmed_at,         type: Time
  # field :confirmation_sent_at, type: Time
  # field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time

  has_many :replies, class_name: 'Reply' , inverse_of: :replies
end

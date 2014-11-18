class Request
  include Mongoid::Document
  include Mongoid::Timestamps

  after_create :notify_possible_donors

  field :patient_name, type: String
    validates_presence_of :patient_name, :message=> "Must enter the patient name!"

  field :contact_name, type: String
    validates_presence_of :contact_name, :message=> "Must enter the contact name!"

  field :contact_phone, type: String
    validates_presence_of :contact_phone, :message=> "Must enter your Mobile number!"
    validates_length_of :contact_phone, minimum: 11, maximum: 11, :message=> "Mobile number must be of length 11.."
    validates_numericality_of :contact_phone, :message=> "Must enter mobile number in numerical form only!"
    validates_uniqueness_of :contact_phone, :message=> "This mobile number is already associated with another user!"



  field :request_no, type: Integer



  field :national_id, type: String
    validates_presence_of :national_id, :message=> "Must enter your ID!"
    validates_length_of :national_id, minimum: 14, maximum: 14, :message=> "ID must be of length 14.."
    validates_numericality_of :national_id, :message=> "Must enter ID in numerical form only!"
    validates_uniqueness_of :national_id, :message=> "This ID is already associated with another user!"

  field :due_date, type: DateTime
    validates_presence_of :due_date, :message=> "Must enter the expected due date!"

  field :blood_bags, type: Integer
    validates_presence_of :blood_bags, :message=> "Must enter needed blood bags!"

  field :email, type: String
    validates_presence_of :email, :message=> "Must enter your email!"
  ##### Relations #####
  has_many :replies
  belongs_to :blood_type
  belongs_to :user
  has_many :reports
  ## END

  ##### Hospital Attributes #####
  field :hospital_name, type: String
    validates_presence_of :hospital_name, :message=> "Must enter the hospital name!"
  field :hospital_phone, type: String
    validates_presence_of :hospital_phone, :message=> "Must enter the hospital phone number!"
  has_one :location, as: :locatable
    validates_presence_of :location, :message=> "Must choose hospital's location!"
  ## END

  field :banned, type: Boolean, default: false
  field :stopped, type: Boolean, default: false

  ##### Methods #####
  def authenticate(national_id_params)
    if national_id == national_id
      true
    else
      false
    end
  end

  def no_of_replies
    replies.count
  end

  def confirmed_donations
    replies.where(confirmed: true)
  end

  def no_of_confirmed_donations
    confirmed_donations.count
  end

  def remaining_blood_bags
    (blood_bags - no_of_confirmed_donations)
  end

  def fulfilled?
    if remaining_blood_bags == 0
      true
    else
      false
    end
  end

  def self.active
    self.where(stopped: false, banned: false, :remaining_blood_bags.gt => 0).select{ |r| r.due_date < DateTime.now }
  end

  def reopen(duration = 2)
    stopped = false
    due_date = DateTime.now + duration
    self.save
  end

  def stop
    stopped = true
    self.save
  end

  def matching_donors
    blood_type.users.select{|u| u.can_donate? == true}
  end

  def notify_possible_donors
    matching_donors.each do |d|
     UserMailer.new_request_email(d, self).deliver
    end
  end

end

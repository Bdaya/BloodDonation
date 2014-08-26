class Report
  include Mongoid::Document
  include Mongoid::Timestamps
  after_create :attach_to_request

  field :message
    validates_presence_of :message, :message=> "Must enter a description of the report!"
  belongs_to :reply
    validates_presence_of :reply, :message=> "Must belong to a certain reply!"
  belongs_to :request

  private
    def attach_to_request
      request = reply.request
      self.save
    end
end

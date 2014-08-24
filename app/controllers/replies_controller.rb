class RepliesController < ApplicationController
  before_action :authenticate_logging_in, only: [:report]
  before_action :authenicate_user!, only: [:cancel]
  before_action { |c| c.prepare_reply(params[:id]) }
  before_action(:only => [:cancel]) { |c| c.require_owner_authority(params[:id]) }
  before_action(:only => [:report]) { |c| c.require_reporter_authority(params[:id]) }

  def report
    the_report = Report.create(message: params[:message], reply: @reply)
    if @reply.update_attribute(:report, the_report)
      redirect_to @reply.request, notice: "We received your report. Thank you!"
    else
      redirect_to @reply.request, alert: "Something went wrong!"
    end
  end

  def cancel
    if @reply.cancel
      redirect_to @reply.request, notice: "Successfully cancelled your reply."
    else
      redirect_to @reply.request, alert: "Something went wrong!"
    end
  end

  private
    def authenticate_logging_in
      unless user_signed_in? || current_request
        redirect_to root_url, alert: "Your must login first!"
      end
    end

    def require_owner_authority
      unless (current_user && (@reply.user == current_user) )
        redirect_to @reply.request, alert: "You can only cancel your replies!"
      end
    end

    def require_reporter_authority
      unless (current_user && (@reply.request.user == current_user) ) || (current_request && (current_request == @reply.request))
        redirect_to @reply.request, alert: "You can only report reply if you own the request!"
      end
    end

    def prepare_request(args)
      @reply = Reply.find(args)
      unless (@reply && @reply.request.present?)
        redirect_to root_path, alert: "Something went wrong!"
      end
    end
end
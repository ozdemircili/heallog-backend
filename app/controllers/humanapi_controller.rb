class HumanapiController < ApplicationController
  skip_before_filter :verify_authenticity_token
  respond_to :json

  def notifications
    parse_notifications(params["_json"])
    render :nothing => true, :status => 200
  end

  private
  def parse_notifications(notifications)
    notifications.each do |notification|
      Patient.register_humanapi_metric(notification)
    end
  end
end


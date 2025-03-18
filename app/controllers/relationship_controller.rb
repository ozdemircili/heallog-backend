class RelationshipController < ApplicationController

  def accept
    relationship = DoctorPatientRelationship.find_by_token(params[:id])

    if relationship.can_accept?
      relationship.accept
      flash[:notice] = "Invite accepted!"
    else
      flash[:error] = "Was not possible to accept the invite!"
    end

    redirect_to root_url
  end
end


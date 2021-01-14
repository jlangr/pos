class MembersController < ApplicationController
  before_action :set_member, only: [:show]

  # GET /members/:id
  def show
    json_response(@member)
  end

  # POST /members
  def create
    @member = Member.create!(member_params)
    json_response(@member, :created)
  end

  private

  def member_params
    params.permit(:name, :phone, :discount)
  end

  def set_member
    @member = Member.find(params[:id])
  end
end


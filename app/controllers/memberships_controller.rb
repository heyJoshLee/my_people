class MembershipsController < ApplicationController
  def create
    Membership.create
  end

end
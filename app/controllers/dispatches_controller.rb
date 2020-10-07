class DispatchesController < ApplicationController
  def index
    @dispatches = Dispatch.includes(:message).all
  end
end

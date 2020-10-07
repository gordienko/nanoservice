# frozen_string_literal: true

class DispatchesController < ApplicationController
  def index
    @dispatches = Dispatch.includes(:message).all
  end
end

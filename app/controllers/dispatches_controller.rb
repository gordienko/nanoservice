# frozen_string_literal: true

class DispatchesController < ApplicationController
  def index
    @dispatches = Dispatch.includes(message: [:user]).limit(1000)
  end
end

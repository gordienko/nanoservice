class SendMessageJob < ApplicationJob
  queue_as :default

  def perform(dispatch)
    implementation_methods_sending_to_messengers(dispatch)
  end

  private

  def implementation_methods_sending_to_messengers(dispatch)
    dispatch.update!(status: :process)
    delay = rand
    sleep delay
    if delay > 0.8
      dispatch.update!(status: :error)
      raise I18n.t('there_was_an_error_sending_your_message')
    else
      dispatch.update!(status: :sent)
    end
  end
end

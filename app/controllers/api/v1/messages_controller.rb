# frozen_string_literal: true

module Api
  module V1
    class MessagesController < ActionController::API
      # acts_as_token_authentication_handler_for User
      before_action :need_authenticate!

      def create
        @message = Message.new(message_params)
        @message.user = current_user

        if @message.save
          render json: { messages: I18n.t('message_sent_for_processing'), is_success: true,
                         data: { message: @message } }, status: :ok
        else
          render json: { messages: @message.errors.messages, is_success: false, data: {} },
                 status: :unprocessable_entity
        end
      end

      private

      def message_params
        params.permit(:body, dispatches_attributes: %i[id phone messenger_type send_at])
      end

      def need_authenticate!
        unless user_signed_in?
          render json: { messages: I18n.t('user_unauthorized'), is_success: false, data: {} },
                 status: :unauthorized
        end
      end
    end
  end
end

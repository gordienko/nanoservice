module Api
  module V1
    class MessagesController < ActionController::API
      # acts_as_token_authentication_handler_for User

      def create
        unless user_signed_in?
          render json: {messages: I18n.t('user_unauthorized'), is_success: false, data: {}}, status: :unauthorized and return
        end

        @message = Message.new(message_params)
        @message.user = current_user

        if @message.save
          render json: {messages: I18n.t('message_sent_for_processing'), is_success: true,
                        data: { message: @message }}, status: :ok
        else
          render json: { messages: @message.errors.messages, is_success: false, data: {}}, status: :unprocessable_entity
        end

      end

      private

      def message_params
        params.permit(:body, dispatches_attributes: [:id, :phone, :messenger_type, :send_at])
      end
    end
  end
end

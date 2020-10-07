module Api
  module V1
    class SessionsController < Devise::SessionsController
      before_action :load_user, only: :create
      skip_before_action :verify_authenticity_token

      def create
        if @user.valid_password?(sign_in_params[:password])
          sign_in "user", @user
          render json: {messages: I18n.t('signed_in_successfully'), is_success: true, data: { user: @user }}, status: :ok
        else
          render json: {messages: I18n.t('signed_in_failed_unauthorized'), is_success: false, data: {}}, status: :unauthorized
        end
      end

      def destroy
        sign_out
        render json: { messages: I18n.t('signed_out_successfully'), is_success: true }, status: :ok
      end

      private

      def sign_in_params
        params.require(:user).permit :email, :password
      end

      def load_user
        @user = User.find_for_database_authentication(email: sign_in_params[:email])
        if @user
          return @user
        else
          render json: {messages: I18n.t('cannot_get_user'), is_success: false, data: {}}, status: :not_found
        end
      end
    end
  end
end

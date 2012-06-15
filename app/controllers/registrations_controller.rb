class RegistrationsController < Devise::RegistrationsController
  private
  
    def build_resource(*args)
      super
      if session[:omniauth]
        @user.build_new_authentication(session[:omniauth])
        @user.valid?
      end
    end
end

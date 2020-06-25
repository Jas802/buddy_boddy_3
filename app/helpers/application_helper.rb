module ApplicationHelper
    def require_login
        redirect_to 'welcome/home' unless user_is_authenticated
    end
    
    def user_is_authenticated
        !current_user.nil?
    end
    
    def current_user
        User.find_by(id: session[:user_id])
    end
end

class ApplicationController < ActionController::Base
    before_action :authenticate_user!  
    before_action :set_breadcrumbs

    private
        def set_breadcrumbs
            add_breadcrumb "Inicio", root_path
        end
end

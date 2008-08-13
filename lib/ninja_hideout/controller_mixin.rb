module NinjaHideout
  module ControllerMixin
    private

    def page_is(title)
      @page_title = title
    end

    alias call_page page_is
    alias title= page_is

    def page_title
      return(@page_title || params[:action].humanize)
    end

    def warn_user(message)
      flash[:warning] = message
    end

    def tell_user(message)
      flash[:notice] = message
    end

    def warn_user_now(message)
      flash.now[:warning] = message
    end

    def tell_user_now(message)
      flash.now[:notice] = message
    end

    def setup_auto_redirect
      session[:auto_redirect_to] = request.request_uri
    end

    def perform_auto_redirect
      @@default_auto_redirect_location ||= '/'
      location = session[:auto_redirect_to] || '/'
      session[:auto_redirect_to] = nil
      redirect_to location
      return false
    end
  end
end
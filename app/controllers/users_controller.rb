class UsersController < ApplicationController

    get "/signup" do
        redirect_if_logged_in
        erb :"users/create_user"
    end
    
    post "/signup" do
        redirect_if_logged_in

        if !!User.find_by_email(params[:email]) || !!User.find_by_username(params[:username])
            redirect "/signup"
        end
        
        user = User.new(params)
        if user.save
            session[:user_id] = user.id
            redirect "/tweets"
        else
            redirect "/signup"
        end
    end

    get "/login" do
        redirect_if_logged_in
        erb :"users/login"
    end
    
    post "/login" do
        redirect_if_logged_in
        user = User.find_by_username(params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect "/tweets"
        else
            redirect "/login"
        end
    end

    get "/logout" do
        if logged_in?
            session.destroy
            redirect to '/login'
        else
            redirect to '/tweets'
        end
    end

    get "/users/:slug" do
        @user = User.find_by_slug(params[:slug])
        erb :"users/show"
    end

    private
    def redirect_if_logged_in
        if logged_in?
            redirect "/tweets"
        end
    end
end
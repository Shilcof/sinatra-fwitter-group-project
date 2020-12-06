class TweetsController < ApplicationController

    get "/tweets" do
        redirect_if_not_logged_in
        @tweets = Tweet.all # .include(:user) #pre-loading here
        erb :"tweets/index"
    end

    get "/tweets/new" do
        redirect_if_not_logged_in
        erb :"tweets/new"
    end

    post "/tweets" do
        redirect_if_not_logged_in
        @tweet = current_user.tweets.build(params[:tweet])
        if current_user.save
            # flash[:message] = "Successfully created song."
            redirect "/tweets/#{@tweet.id}"
        else
            redirect "/tweets/new"
        end
    end

    get "/tweets/:id" do
        redirect_if_not_logged_in
        @tweet = Tweet.find(params[:id])
        @user = @tweet.user
        erb :"tweets/show"
    end

    get "/tweets/:id/edit" do
        redirect_if_not_logged_in
        @tweet = Tweet.find(params[:id])
        erb :"tweets/edit"
    end

    patch "/tweets/:id" do
        redirect_if_not_logged_in
        @tweet = Tweet.find(params[:id])


        if current_user == @tweet.user
            if @tweet.update(params[:tweet])
            else
                redirect "/tweets/#{@tweet.id}/edit"
            end
        end

        redirect "/tweets"

    end

    delete "/tweets/:id" do
        redirect_if_not_logged_in
        @tweet = Tweet.find(params[:id])
        if current_user == @tweet.user
            @tweet.destroy
        end
        redirect "/tweets"
    end

end

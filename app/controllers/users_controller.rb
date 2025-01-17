class UsersController < ApplicationController

  def index

  matching_users = User.all
    
  @list_of_users=  matching_users.order({ :username => :asc})

  render ({ :template => "users_templates/index.html.erb" })
  end

  def show
    url_username = params.fetch("path_username")
    matching_usernames = User.where({:username => url_username})
    @the_user =  matching_usernames.at(0)
    if @the_user == nil
      redirect_to("/404")
    else
      render ({ :template => "users_templates/show.html.erb" })
    end
  end

  def create_user

    input_username = params.fetch("query_username")

    a_new_user = User.new

    a_new_user.username = input_username

    a_new_user.save

    redirect_to("/users/" + a_new_user.username)
    #render ({ :template => "users_templates/create_user.html.erb" })
  end



  def update
    #Parameters: {"query_username"=>"anisaaaaa", "path_user_id"=>"117"}  
    user_id = params.fetch("path_user_id")
    matching_users = User.where({:id => user_id})
    the_user = matching_users.at(0)

    input_username = params.fetch("query_username")
    the_user.username = input_username

    the_user.save

    #render ({ :template => "users_templates/update.html.erb" })
    next_url = "/users/" + the_user.username.to_s
    redirect_to(next_url)
  end

end
 

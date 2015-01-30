# render home page
get '/' do

  @first_name = generate_first
  @last_name = generate_last

  if current_user
    @user = User.find(current_user.id)
  end
  if request.xhr?
    return {first_name: @first_name, last_name:@last_name}.to_json
  else
    erb :index, locals: {first_name: @first_name, last_name: @last_name, user: @user}

  end
end

#save random name
post '/name' do
  @user_id = current_user.id
  @first_name = FirstName.find_by(first_name: params[:first_name]).id
  @last_name = LastName.find_by(last_name: params[:last_name]).id
  @entry = Entry.create(user_id: "#{@user_id}", first_name_id: "#{@first_name}", last_name_id: "#{@last_name}")
  if request.xhr?
    return @entry.to_json
  else
    redirect to('/')
  end
end



#render sign up page
get '/sign_up' do

  erb :sign_up
end

post '/sign_up' do
  user = User.new(params[:user])

  if user.save
    session[:user_id] = user.id
    redirect to('/')
  else
    set_error("Either username is taken or passwords do not match.")
    redirect to('/sign_up')
  end
end

#render sign in page
get '/sign_in' do

  erb :sign_in
end

post '/sign_in' do
  user = User.find_by(username: params[:username])
  if user
    session[:user_id] = user.id
    redirect to('/')
  else
    set_error("Username or password incorrect.")
    redirect to('/sign_in')
  end
end

#logout

get '/logout' do
  session[:user_id] = nil
  redirect to('/')
end

#show list of all users
get '/show_all' do
  @users = User.all
  erb :'/all', locals: {users: @users}
end

#show user profile with their list

get '/user/:id' do |id|
  @user = User.find(id)

  erb :'/user/show', locals: {user: @user}
end


#edit user profile

get '/user/:id/edit' do |id|
  @user = User.find(id)
  erb :'/user/edit', locals: {user: @user}
end

put '/user/:id/edit' do |id|
  if current_user
    @user = User.find(id)
    @user.update(params[:user])
  else
    set_error("You do not have permission to edit this.")
  end

  if  request.xhr?

    return params[:user].to_json
  else
    redirect to("/user/#{@user.id}")
  end
end

#show new note form
get "/entry/:id/note" do |id|
  @entry = Entry.find(id)

  erb :'/entry/note', locals: {entry: @entry}
end

#update note on entry

put "/entry/:id" do |id|
  @user = User.find(current_user.id)
  @entry = Entry.find(id)
  @entry.update(params[:note])
  if request.xhr?
    return @entry.note
  else
    redirect to("/user/#{@user.id}")
  end
end


#see edit note

get "/entry/:id/edit" do |id|
  @entry = Entry.find(id)

  erb :'/entry/note', locals: {entry: @entry}
end

put "/entry/:id/edit" do |id|
  @user = User.find(current_user.id)
  @entry = Entry.find(id)
  @entry.update(params[:note])

  redirect to("/user/#{@user.id}")
end

#delete note through update to nil

put "/note/:id/delete" do |id|
  @user = User.find(current_user.id)
  @entry = Entry.find(id)
  @entry.update(note: nil)

  if request.xhr?
    return @entry
  else
    redirect to("/user/#{@user.id}")
  end
end

#Delete name from profile

delete "/entry/:id/delete" do |id|
  @user = User.find(current_user.id)
  @entry = Entry.find(id)
  @entry.destroy

  redirect to("/user/#{@user.id}")
end

# Delete user's account
delete "/user/:id/delete" do |id|
  @user = User.find(current_user.id)

  @user.entries.each do |entry|
    @entry.destroy
  end
  @user.destroy

  session[:user_id] = nil

  redirect to("/")
end








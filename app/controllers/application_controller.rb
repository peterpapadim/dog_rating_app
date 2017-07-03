class ApplicationController < Sinatra::Base

  set :views, Proc.new { File.join(root, "../views/") }
  register Sinatra::Twitter::Bootstrap::Assets

  get '/users' do
    @users = User.all.sort_by {|user| user.name}
    erb :'users/index'
  end

  get '/' do
    @puppy_lover_count = User.all.count
    erb :root
  end



  get '/users/new' do
    erb :'/users/new'
  end

  post '/users/new' do
    if User.find_by(name: params[:name]) == nil
      User.create(name: params[:name])
      redirect '/users/success'
    else
      redirect '/users/failure'
    end
  end

  get '/users/success' do
    erb :'/users/success'
  end

  get '/users/failure' do
    erb :'/users/failure'
  end

  get '/users/:id/photos' do
    @user = User.find_by(id: params[:id])
    erb :'/users/photos'
  end

  get '/users/:id/photos/new' do
    @user = User.find_by(id: params[:id])
    erb :'/users/new_photo'
  end

  post '/users/:id/photos/new' do
    if params[:photo][:title] && params[:photo][:url] != nil
      new_photo = Photo.create(params[:photo])
      new_photo.user = User.find(params[:id])
      new_photo.save
    end
    redirect "users/#{params[:id]}/photos"
  end

  get '/users/:id' do
    redirect :"/users/#{params[:id]}/photos"
  end

  get '/photos/:id' do
    @photo = Photo.find(params[:id])
    erb :'/photos/photo'
  end

  get '/photos/:id/ratings' do
    @photo = Photo.find(params[:id])
    erb :'/ratings/photo_ratings'
  end

  get '/photos/:id/edit' do
    @photo = Photo.find(params[:id])
    @user = @photo.user
    erb :'/photos/edit'
  end

  post '/photos/:id/edit' do #this should be patch but we are lazy
    photo = Photo.find(params[:id])
    photo.update(params[:photo])
    redirect "/photos/#{photo.id}"
  end

  get '/photos/:id/delete' do
    @photo = Photo.find(params[:id])
    @user = @photo.user.id
    @photo.destroy
    redirect :"/users/#{@user}"
  end

  get '/photos/:id/ratings/new' do
    @photo = Photo.find(params[:id])
    erb :'/ratings/new'
  end

  post '/photos/:id/ratings' do
    user = User.find_or_create_by(name: params[:name])
    rating = Rating.create(score: params[:rating])
    rating.photo = Photo.find(params[:id])
    rating.user = user
    rating.save
    redirect "/photos/#{params[:id]}/ratings"
  end


end

class Admin::UsersController < ApplicationController
  before_action :if_not_admin

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def index
    @user = User.find(params[:id])
    @book = Book.new
    @users = User.all
  end

  #def create
    #@book = Book.new(book_params)
    #@book.user_id = current_user.id
    #@book.save
    #redirect_to book_path @book

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render :edit
    else
      redirect_to user_path current_user
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path @user
    else
      render :edit
    end
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
  
  def if_not_admin
    redirect_to root_path unless current_user.admin?
  end
end

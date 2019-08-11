class UsersController < ApplicationController
before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
before_action :correct_user,   only: [:edit, :update]
before_action :admin_user,     only: :destroy 


  def index
    @users=User.all
  end

  def show
  @user = User.find(params[:id])
  end

  def new
  @user = User.new
  end
  
  def create
    @user = User.new(user_params) #user params son solo los permitidos (ver más adelante)
    if @user.save
      log_in @user #una vez que salvaste te logguea!
      # Handle a successful save. y redirige al profile del usuario:
        flash[:success] = "Benviendo a a App de Capsulas de Empleados!"
        redirect_to @user
    else
      render 'new'
    end
  end

 def edit
    @user = User.find(params[:id])
 end

def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
        flash[:success] = "Profile updated"
      redirect_to @user
      # Handle a successful update.
    else
      render 'edit'
    end
end

def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
end

  private

    def user_params #Defino los permitodos a agregar:  habría que agregar el sitio de trabajo (btq/área de oficina)
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation, :area)
    end
       # Before filters

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end  
    
     # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    
    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end



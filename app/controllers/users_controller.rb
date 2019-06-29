class UsersController < ApplicationController


  def show
  @user = User.find(params[:id])
  end

  def new
  @user = User.new
  end
  
  def create
    @user = User.new(user_params) #user params son solo los permitidos (ver más adelante)
    if @user.save
      # Handle a successful save. y redirige al profile del usuario:
        flash[:success] = "Benviendo a a App de Capsulas de Empleados!"
        redirect_to @user
    else
      render 'new'
    end
  end

  private

    def user_params #Defino los permitodos a agregar:
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end



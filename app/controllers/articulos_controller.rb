class ArticulosController < ApplicationController
  http_basic_authenticate_with name: "nasugo", password: "JEPA", except: [:index, :show]
  def new
    @articulo = Articulo.new
  end

  def index
    @articulos = Articulo.all
  end

  def create
    # render plain: params[:articulo].inspect
    @articulo = Articulo.new(params.require(:articulo).permit(:title, :text))

    if @articulo.save
      flash[:notice] = "Articulo creado correctamente"
      redirect_to @articulo
    else
      flash[:error] = "No pudo crear articulo"
      render 'new'
    end
  end

  def show
    @articulo = Articulo.find(params[:id])
  end

  def edit
    @articulo = Articulo.find { params[:id] }
  end

  def update

    session[:articuloID] = params[:id]
    @articulo = Articulo.find { session[:articuloID]  }
    session.delete(:articuloID)

    if @articulo.update(articulo_params)
      redirect_to @articulo
    else
      render 'edit'
    end

  end

  def destroy
    @articulo = Articulo.find(params[:id])
    @articulo.destroy

    redirect_to articulos_path

  end

  private
    def articulo_params
      params.require(:articulo).permit(:title, :text)
    end



end

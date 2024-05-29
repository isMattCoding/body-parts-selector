class BodiesController < ApplicationController
  def index
    @bodys = Body.all
  end

  def show
    @body = Body.find(params[:id])
  end

  def new
    @body = Body.new
  end

  def create
    @body = Body.new(body_params)

    if @body.save
      redirect_to "/"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def body_symptoms
    @side = params[:side]
    @link = link_params[:parts]
    respond_to do |format|
      format.turbo_stream
    end
  end

  def destroy
    @body = Body.find(params[:id])
    @body.destroy

    redirect_to root_path, status: :see_other
  end

  private

  def body_params
    params.require(:body).permit(:parts)
  end

  def link_params
    params.permit(:parts, :side)
  end
end

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
    @body.parts = parse(body_params[:parts])

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

  def edit
    @body = Body.find(params[:id])
  end

  def update
    @body = Body.find(params[:id])

    if @body.update(body_params)
      redirect_to @body
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @body = Body.find(params[:id])
    @body.destroy

    redirect_to root_path, status: :see_other
  end

  private

  def parse(body_symptoms_to_parse)
    possible_parts = %w(back-knee-right back-shoulder-left back-elbow-left back-head back-upper-arm-left back-forearm-left back-shoulder-right back-elbow-right back-upper-arm-right back-forearm-right back-foot-right back-calf-right back-knee-left back-buttock-left back-foot-left back-calf-left back-thigh-left back-buttock-right back-thigh-right back-torso back-neck back-hand-left back-hand-right front-knee-right front-shoulder-left front-elbow-left front-head front-upper-arm-left front-lower-arm-left front-shoulder-right front-elbow-right front-upper-arm-right front-lower-arm-right front-foot-right front-calf-right front-knee-left front-hip-left front-foot-left front-calf-left front-thigh-left front-hip-right front-thigh-right front-torso front-neck front-hand-left front-hand-right)
    parts_parsed = body_symptoms_to_parse.split(", ").reject { |p| p.empty? }
    parts_parsed = parts_parsed.reject { |p| possible_parts.exclude?(p)}.join(", ")
  end

  def body_params
    params.require(:body).permit(:parts)
  end

  def link_params
    params.permit(:parts, :side)
  end
end

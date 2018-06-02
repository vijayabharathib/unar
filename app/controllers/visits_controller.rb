class VisitsController < ApplicationController
  before_action :set_visit, only: [:show, :update, :destroy]

  # GET /visits
  def index
    @visits = Visit.total_visit_by_url

    render json: @visits
  end

  # GET /visits/1
  def show
    render json: @visit
  end

  # POST /visits
  def create
    #TODO unique visitor ip hash anonymous
    @visit = Visit.new(visit_params)
    @visit.browser=request.env["HTTP_USER_AGENT"]
    @visit.domain=request.env["HTTP_ORIGIN"]
    path=request.env["HTTP_REFERER"]
    path.slice!(@visit[:domain])
    @visit.path=path
    ip=request.remote_ip.split('.',3)
    @visit.ip="#{ip.first}.#{ip[1]}.1.1"
    if @visit.save
      render json: @visit, status: :created, location: @visit
    else
      render json: @visit.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /visits/1
  def update
    if @visit.update({:retention=>visit_params[:retention]})
      render json: @visit
    else
      render json: @visit.errors, status: :unprocessable_entity
    end
  end

  # DELETE /visits/1
  def destroy
    @visit.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_visit
      @visit = Visit.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def visit_params
      # :ip removed from this list as it is taken from the backend
      # using request.remote_ip
      params.require(:visit).permit(:domain, :path, :device, :country, :referer, :keyword, :bounce, :retention, :browser, :version)
    end
end

class VisitsController < ApplicationController
  before_action :set_visit, only: [:show, :update, :destroy]

  # GET /visits
  def index
    if !params[:group].nil? 
      by=params[:group]
      if by=="country"
        @visits=Visit.group(by).count('id')
      elsif by=="path"
        @visits=Visit.group(by).count('id')
      else
        @visits=nil
      end
    elsif !params[:domain].nil?
      @visits = Visit.by_domain(params[:domain]).group_by_date
    else
      @visits=nil
    end 
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
      p=params.require(:visit).permit(:id,:referer, :keyword, :retention)
      
      # prepare rest of the parameters from request object
      p[:browser]=request.env["HTTP_USER_AGENT"]
      domain=request.env["HTTP_ORIGIN"]
      path=request.env["HTTP_REFERER"]
      path.slice!(domain)
      x=domain.index(/\/\//)+2
      p[:domain]=domain[x..-1]
      p[:path]=path
      ip=request.remote_ip.split('.',3)
      p[:ip]="#{ip.first}.#{ip[1]}.1.1"
      return p
    end
end

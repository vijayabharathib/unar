class VisitsController < ApplicationController
  # before_action :set_visit, only: [:show, :update, :destroy]

  # GET /visits
  def index
    if !params[:group].nil? 
      by=params[:group]
      if by=="country" || by=="path" || by=="referer" || by=="browser"
        @visits=Visit.group(by).count('id')
      elsif by=="week"
        @visits=Visit.by_week
      else
        @visits=nil
      end
    elsif !params[:domain].nil?
      @visits = Visit.by_domain(params[:domain]).group_by_date
    else
      @visits=Visit.group_by_date
    end 
    render json: @visits
  end

  # GET /visits/1
  def show
    render json: @visit
  end

  # POST /visits
  def create
    # hashed_ip=BCrypt::Password.create(visit_params[:ip])
    # @visitor=Visitor.find_or_create_by(identity: hashed_ip.to_s)
    @visit = Visit.new(visit_params)
    visit_time=@visit.push_to_firestore 
    @visit.created_at = visit_time

    begin
      @visit.save  
      render json: @visit, status: :created, location: @visit
    rescue 
      render json: @visit, status: :accepted, location: @visit
    end
  end

  # PATCH/PUT /visits/1
  def update
    begin 
      set_visit
      @visit.update({:retention=>visit_params[:retention]})
    rescue
      @visit = Visit.new(visit_params)
    end
    @visit.push_to_firestore
    render json: @visit 
  end

  # DELETE /visits/1
  def destroy
    @visit.destroy
  end

  def vacuum 
    if Visit.all.count > 8000
      max_id = Visit.limit(1).offset(1000)[0].id 
      Visit.where("id < ?",max_id).delete_all 
      response = { delete: 'success' }
      render json: response
    else
      response = { delete: 'rows-within-threshold'}
      render json: response, status: :not_modified 
    end
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
      p=params.require(:visit).permit(:id,:referer, :keyword, :retention,:created_at)
      
      # prepare rest of the parameters from request object
      p[:browser]=request.env["HTTP_USER_AGENT"]
      domain=request.env['HTTP_ORIGIN']
      path=request.env["HTTP_REFERER"]
      path.slice!(domain)
      p[:domain]=URI.parse(domain).host.sub(/^www\./, '')
      p[:path]=path
      ip=request.remote_ip.split('.',3)
      p[:ip]="#{ip.first}.#{ip[1]}.1.1"
      return p
    end
end

class ProbesController < ApplicationController
  layout 'application'

  def index
    @probes = Probe.order('field_id DESC')
    @fields = Field.all
  end

  def new
    @field = Field.find(params[:field_id])
    @probe = Probe.new
    @probe.field_id = @field.id
  end

  def create
     @probe = Probe.new(probe_params)
     @field = Field.find(@probe.field_id)
    if @probe.save
      redirect_to :action => 'show', :id => @probe.id
    else
     render 'new'
    end
  end

  def show
    @probe = Probe.find(params[:id])
    @chill_begin_date = Date.parse("15-05-#{Date.today.year}")
    @chill_end_date = Date.parse("30-08-#{Date.today.year}")
    @chill_units_range = @probe.degrees.where('degrees.created_at BETWEEN ? AND ?',@chill_begin_date,@chill_end_date)
  end

  def edit
    @probe = Probe.find(params[:id])
    @field = Field.find(@probe.field_id)
  end

  def update
    @probe = Probe.find(params[:id])
    if @probe.update(probe_params)
      redirect_to @probe
    else
      render 'edit'
    end
  end

  private

  def probe_params
    params.require(:probe).permit(:name,:field_id, :latitude, :longitude, :elevation, :description)
  end
end



class FieldsController < ApplicationController

  layout 'application'
  def index
    @fields = Field.order('size DESC')
  end

  def new
    @field = Field.new

  end

  def create
    @field = Field.new(field_params)
    if @field.save
      redirect_to :action => 'show', :id => @field.id
    else
      render 'new'
    end
  end

  def show
    @field = Field.find(params[:id])
    @chill_begin_date = Date.parse("15-05-#{Date.today.year}")
    @chill_end_date = Date.parse("30-08-#{Date.today.year}")
    @chill_units_by_probe = Degree.joins(:probe).where('degrees.created_at BETWEEN ? AND ? AND probes.field_id = ?',@chill_begin_date,@chill_end_date,@field.id).group('degrees.probe_id').select('degrees.probe_id, SUM(cold_units_utah) as chill_units')
  end

  def edit
    @field = Field.find(params[:id])
  end

  def update
    @field = Field.find(params[:id])
    if @field.update(field_params)
      redirect_to @field
    else
      render 'edit'
    end
  end
  private

  def field_params
    params.require(:field).permit(:name,:field_polygon, :latitude, :longitude)
  end

end

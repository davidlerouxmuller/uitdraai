class DegreesController < ApplicationController
  layout 'application'
  def new
    @probe = Probe.find(params[:probe_id])
  end

  def upload_logs
    puts "xxxxxxxxx"
    puts "xxxxxxxxx"
    puts "xxxxxxxxx"
    puts "xxxxxxxxx"
    puts "xxxxxxxxx"
    puts "xxxxxxxxx"
    puts "xxxxxxxxx"
    puts "xxxxxxxxx"
    if params[:file].present? && !params[:file].blank?
      data = SmarterCSV.process(params[:file].path)
      data.each do |row|
        timestamp = DateTime.parse(row[:date])
        log = Degree.find_or_create_by(:probe_id => params[:probe_id],:created_at => timestamp.beginning_of_hour,)
        log.reading = row[:degree]
        if log.reading < 1.4
          log.cold_units_utah = 0
        elsif log.reading < 2.5
          log.cold_units_utah = 0.5
        elsif log.reading <= 9
          log.cold_units_utah = 1
        elsif log.reading < 12.6
          log.cold_units_utah = 0.5
        elsif log.reading < 16
          log.cold_units_utah = 0
        elsif log.reading <= 18
          log.cold_units_utah = -0.5
        elsif log.reading > 18
          log.cold_units_utah = -1
        end
        log.save!
      end
      flash[:success] = 'file uploaded and processed'
      redirect_to :action => 'new', :probe_id => params[:probe_id]
    else
      flash[:error] = 'No file uploaded'
      redirect_to :action => 'new', :probe_id => params[:probe_id]
    end

  end
end

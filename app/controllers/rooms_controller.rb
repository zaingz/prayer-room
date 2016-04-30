class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update, :destroy ,:creport]
  before_action :authenticate_user!, except: [:index]

  # GET /rooms
  # GET /rooms.json
  def index
    @rooms = Room.all
  end

  # GET /rooms/1
  # GET /rooms/1.json
  def show
  end

  # GET /rooms/new
  def new
    @room = Room.new
  end

  # GET /rooms/1/edit
  def edit
  end

  # POST /rooms
  # POST /rooms.json
  def create
    @room = Room.new(room_params)

    respond_to do |format|
      if params[:photo].present?
        @room.user_id = current_user.id
        if @room.save
          params[:photo]['image'].each do |a|
            @photo = @room.photos.create!(:image => a, :room_id => @room.id)
          end
          format.html { redirect_to @room, notice: 'Room was successfully created.' }
          format.json { render :show, status: :created, location: @room }
        else
          format.html { render :new }
          format.json { render json: @room.errors, status: :unprocessable_entity }
        end
      else
        format.html { render :new}
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rooms/1
  # PATCH/PUT /rooms/1.json
  def update
    respond_to do |format|
      if @room.update(room_params)
        format.html { redirect_to @room, notice: 'Room was successfully updated.' }
        format.json { render :show, status: :ok, location: @room }
      else
        format.html { render :edit }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rooms/1
  # DELETE /rooms/1.json
  def destroy
    @room.destroy
    respond_to do |format|
      format.html { redirect_to rooms_url, notice: 'Room was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def report

  end

  def creport
    if @room.reports.find_by_reporter_id(current_user.id).nil?
      report = Report.new()
      report.status = params[:status].to_i
      report.room_id = @room.id
      report.reporter_id = current_user.id
      respond_to do |format|
        if report.save
          format.html { redirect_to rooms_path, notice: 'Report was successfully generated.' }
          format.json { render :show, status: :ok, location: @room }
        else
          format.html { render :index }
          format.json { render json: @room.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
          format.html { redirect_to rooms_path, notice: 'Report was already generated.' }
          format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def room_params
      params.require(:room).permit(:name, :street, :floor, :city, :country, :description, :direction, :link , photos_attributes: [:image])
    end
end

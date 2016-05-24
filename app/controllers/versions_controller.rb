class VersionsController < ApplicationController
  before_action :set_version, only: [:show, :edit, :update, :destroy ,:creport , :voteup]
  before_action :authenticate_user!, except: [:index , :show]

  # GET /versions
  # GET /versions.json
  def index
    if user_signed_in?
      redirect_to admin_room_entries_path if current_user.role == 'admin'
    end
    
    @versions = Version.approved.paginate(:page => params[:page], :per_page => 4)

    p params
    if params[:name].present? || params[:city].present? || params[:country].present?
      @versions = @versions.where(name: params[:name]) if params[:name]!=""
      @versions = @versions.where(city: params[:city]) if params[:city]!=""
      @versions = @versions.where(country: params[:country]) if params[:country]!=""
    end
  end

  # GET /versions/1
  # GET /versions/1.json
  def show
  end

  # GET /versions/new
  def new
    @version = Version.new
  end

  # GET /versions/1/edit
  def edit
  end

  # POST /versions
  # POST /versions.json
  def create
    @room = Room.create(user_id: current_user.id)
    @version = Version.new(version_params)
    @version.typ  = 0
    respond_to do |format|
      if params[:photo].present?
        if @version.save
          @version.update(room_id: @room.id)
          if params[:photo]['image']['0'].present?
            @photo = @version.photos.create!(:image => params[:photo]['image']['0'], :version_id => @version.id)
            if params[:photo]['image']['1'].present?
              @photo = @version.photos.create!(:image => params[:photo]['image']['1'], :version_id => @version.id)
              if params[:photo]['image']['2'].present?
                @photo = @version.photos.create!(:image => params[:photo]['image']['2'], :version_id => @version.id)
                if params[:photo]['image']['3'].present?
                  @photo = @version.photos.create!(:image => params[:photo]['image']['3'], :version_id => @version.id)
                end
              end
            end
          end
          format.html { redirect_to @version, notice: 'Version was successfully created.' }
          format.json { render :show, status: :created, location: @version }
        else
          format.html { render :new }
          format.json { render json: @version.errors, status: :unprocessable_entity }
        end
      else
        format.html { render :new, notice: 'Photos cant be empty.'}
        format.json { render json: @version.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /versions/1
  # PATCH/PUT /versions/1.json
  def update
    if current_user.role == 'admin'
      @version.update(version_params)
      redirect_to admin_room_entries_path, notice: 'Version was successfully updated.'
    else
      if @version.room.versions.count == 1
        version = Version.new(version_params)
        version.room_id = @version.room.id
        version.typ  = 1
        respond_to do |format|
          if version.save
            if params[:photo].present?
              if params[:photo]['image']['0'].present?
                photo = version.photos.create!(:image => params[:photo]['image']['0'], :version_id => version.id)
                if params[:photo]['image']['1'].present?
                  photo = version.photos.create!(:image => params[:photo]['image']['1'], :version_id => version.id)
                  if params[:photo]['image']['2'].present?
                    photo = version.photos.create!(:image => params[:photo]['image']['2'], :version_id => version.id)
                    if params[:photo]['image']['3'].present?
                      photo = version.photos.create!(:image => params[:photo]['image']['3'], :version_id => version.id)
                    end
                  end
                end
              else
                @version.photos.each do |a|
                  p a
                  photo = version.photos.create!(:image => a, :version_id => @version.id)
                end
              end
            else
              @version.photos.each do |a|
                p a
                photo = version.photos.create!(:image => a, :version_id => @version.id)
              end
            end
            format.html { redirect_to version_path, notice: 'Version was successfully updated.' }
            format.json { render :show, status: :ok, location: version }
          else
            format.html { render :edit }
            format.json { render json: version.errors, status: :unprocessable_entity }
          end
        end
      else
        redirect_to root_path, notice: 'Updated version of room is already present.'
      end
    end
  end

  # DELETE /versions/1
  # DELETE /versions/1.json
  def destroy
    @version.destroy
    respond_to do |format|
      format.html { redirect_to versions_url, notice: 'Version was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def report

  end

  def creport
    if @version.reports.find_by_reporter_id(current_user.id).nil?
      report = Report.new()
      report.status = params[:status].to_i
      report.version_id = @version.id
      report.reporter_id = current_user.id
      respond_to do |format|
        if report.save
          format.html { redirect_to versions_path, notice: 'Report was successfully generated.' }
          format.json { render :show, status: :ok, location: @version }
        else
          format.html { render :index }
          format.json { render json: @version.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
          format.html { redirect_to versions_path, notice: 'Report was already generated.' }
          format.json { render json: @version.errors, status: :unprocessable_entity }
      end
    end
  end

  def voteup
    if Voteup.where(:version_id => @version.id , :user_id => current_user.id).count>0
      redirect_to :back ,  notice: 'Already Voted.' 
    else
      vote = Voteup.create(version_id: @version.id , user_id: current_user.id)
      redirect_to :back , notice: 'Voted.'
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_version
      @version = Version.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def version_params
      params.require(:version).permit(:name, :street, :floor, :city, :country, :description, :direction, :link , photos_attributes: [:image])
    end
end

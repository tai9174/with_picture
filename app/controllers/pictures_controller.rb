class PicturesController < ApplicationController
  # before_action :ensure_user, only: %i[ show edit update destroy ]
  before_action :set_picture, only: %i[ show edit update destroy ]
  # GET /pictures or /pictures.json
  def index
    @pictures = Picture.all
  end

  # GET /pictures/1 or /pictures/1.json
  def show
    @favorite = current_user.favorites.find_by(picture_id: @picture.id)
  end

  # GET /pictures/new
  def new
    if params[:back]
      @picture = Picture.new(picture_params)
    else
      @picture = Picture.new
    end
  end

  # GET /pictures/1/edit
  def edit
  end

  # POST /pictures or /pictures.json
  def create
    @picture = current_user.pictures.build(picture_params)

    respond_to do |format|
      if @picture.save
        PictureMailer.picture_mail(@picture).deliver
        format.html { redirect_to picture_url(@picture), notice: "Picture was successfully created." }
        format.json { render :show, status: :created, location: @picture }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    # @picture = Picture.find(params[:id])
    respond_to do |format|
      if @picture.update(picture_params)
        format.html { redirect_to picture_url(@picture), notice: "Picture was successfully updated." }
        format.json { render :show, status: :ok, location: @picture }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @picture.destroy
    respond_to do |format|
      format.html { redirect_to pictures_url, notice: "Picture was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def confirm
    @picture = current_user.pictures.build(picture_params)

    render :new if @picture.invalid?
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_picture
      @picture = Picture.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def picture_params
      params.require(:picture).permit(:image, :image_cache,:content)
    end


end


class PreferencesController < ApplicationController
  before_action :set_preference, only: [:show, :edit, :update, :destroy]

  def index
    @preferences = Preference.all
  end

  def show
  end

  def new
    @preference = Preference.new
  end

  def edit
  end

  # POST /preferences
  def create
    @preference = Preference.new(preference_params)

    if @preference.save
      redirect_to @preference, notice: 'Preference was successfully created.'
    else
      render :new
    end
  end

  def update
    if @preference.update(preference_params)
      redirect_to @preference, notice: 'Preference was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @preference.destroy
    redirect_to preferences_url, notice: 'Preference was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_preference
      @preference = Preference.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def preference_params
      params.require(:preference).permit(:name)
    end
end

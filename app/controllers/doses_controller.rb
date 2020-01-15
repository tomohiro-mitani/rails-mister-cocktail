class DosesController < ApplicationController
  def new
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose = Dose.new
  end

  def create
    @cocktail = Cocktail.find(params[:cocktail_id])
    @ingredient = Ingredient.find(params[:dose]["ingredient_id"]) if Ingredient.exists?(params[:dose]["ingredient_id"])
    @dose = Dose.new(dose_params)
    @dose.cocktail = @cocktail
    @dose.ingredient = @ingredient
    if @dose.save
      redirect_to cocktail_path(@cocktail)
    else
      render :new
    end
  end

  def destroy
    @dose = Dose.find(params[:id])
    @dose.destroy
  end
 
  private

  def dose_params
    params.require(:dose).permit(:description)
  end

end

# DosesController
#   GET new
#     assigns a new dose as @dose (FAILED - 1)
#   POST create
#     with valid params
#       creates a new Dose (FAILED - 2)
#       assigns a newly created dose as @dose (FAILED - 3)
#       redirects to the created dose (FAILED - 4)
#     with invalid params
#       assigns a newly created but unsaved dose as @dose (FAILED - 5)
#       re-renders the 'new' template (FAILED - 6)
#   DELETE destroy
#     deletes a Dose (FAILED - 7)
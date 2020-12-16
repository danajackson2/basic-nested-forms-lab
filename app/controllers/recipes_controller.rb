class RecipesController < ApplicationController
  def show
    @recipe = Recipe.find(params[:id])
  end

  def index
    @recipes = Recipe.all
  end

  def new
    @recipe = Recipe.new
    @recipe.ingredients.build
    @recipe.ingredients.build
  end

  def create
    @recipe = Recipe.create(recipe_params)
      ingredients_attributes.each do |k,v|
        Ingredient.create(name: v["name"], quantity: v["quantity"], recipe_id: @recipe.id)   
      end
    redirect_to @recipe
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title)
  end

  def ingredients_attributes
    params["recipe"]["ingredients_attributes"]
  end

end

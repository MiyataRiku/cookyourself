class RecipesController < ApplicationController
   def index
        @recipes = Recipe.all
        @tags = Tag.all # ← タグを使っているならこれも必要

      if params[:search].present?
         keyword = "%#{params[:search]}%"
         @recipes = Recipe.where(
            "name LIKE :kw OR material LIKE :kw OR kcal LIKE :kw OR time LIKE :kw OR price LIKE :kw",
           kw: keyword
         )
      else
         @recipes = Recipe.all
      end

    end  
  
   def new
        @recipe = Recipe.new
        @tags = Tag.all
    end

    def create
        @recipe = Recipe.new(recipe_params)
        @tags = Tag.all
        
        @recipe = current_user.recipes.build(recipe_params)


        if @recipe.save
           redirect_to :action => "index"
        else
           redirect_to :action => "new"
        end

    end

    def show
         @recipe = Recipe.find_by(id: params[:id])
         @recipes = Recipe.all
         @comments = @recipe.comments
         @comment = Comment.new
    end


    def edit
        @recipe = Recipe.find_by(id: params[:id])
        @recipes = Recipe.all
    end


    def update
     recipe = Recipe.find_by(id: params[:id])
     if recipe.update(recipe_params)
      redirect_to :action => "show", :id => recipe.id
     else
      redirect_to :action => "new"
     end
    end

    def destroy
      recipe = Recipe.find(params[:id])
      recipe.destroy
      redirect_to action: :index
    end


    private
    def recipe_params
           params.require(:recipe).permit(:kcal, :nut, :time, :process, :material, :price, :name, :image, :tips, tag_ids: [])
    end
    
end
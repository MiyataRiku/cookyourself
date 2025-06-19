class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all # まず全てのレシピを取得

    # タグによる絞り込み
    if params[:tag_id].present?
      # tag_id が配列で渡される可能性も考慮し、includesとwhereを使う
      # N+1問題も考慮し、joinsではなくincludesを使用（またはeager_load）
      @recipes = @recipes.joins(:tags).where(tags: { id: params[:tag_id] })
    end

    # キーワード検索（タグ絞り込みの結果に対して適用する）
    if params[:search].present?
      search_term = "%#{params[:search]}%"
      @recipes = @recipes.where("name ILIKE :search OR material ILIKE :search OR CAST(kcal AS TEXT) ILIKE :search OR CAST(time AS TEXT) ILIKE :search OR CAST(price AS TEXT) ILIKE :search", search: search_term)
    end
    
    @tags = Tag.all # タグリストは常に必要なので、検索・絞り込みの条件に関わらず取得
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
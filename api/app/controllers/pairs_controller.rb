class PairsController < ApplicationController
    def index
      @pairs = Pair.all
    end
  
    def new
      @pair = Pair.new
    end
  
    def create
      @pair = Pair.new(pair_params)
      if @pair.save
        redirect_to pairs_path
      else
        render :new
      end
    end
  
    def edit
      @pair = Pair.find(params[:id])
    end
  
    def update
      @pair = Pair.find(params[:id])
      if @pair.update(pair_params)
        redirect_to pairs_path
      else
        render :edit
      end
    end
  
    def destroy
      @pair = Pair.find(params[:id])
      @pair.destroy
      redirect_to pairs_path
    end
  
    private
  
    def pair_params
      params.require(:pair).permit(:week_no, :student1_id, :student2_id, :student1_user_id, :student2_user_id)
    end
  end
  
class TrainersController < ApplicationController
    include ApplicationHelper
    
    def index
        @trainers = Trainer.search(params[:search])
    end

    def show
        @trainer = Trainer.find_by(id: params[:id])
    end

    def new
       @trainer = Trainer.new 
    end

    def create
        trainer = Trainer.create(trainer_params)
        redirect_to trainer_path(trainer)
    end

    private
    def trainer_params
        params.require(:trainer).permit(
            :name,
            :bio,
            :search
        )
    end
end
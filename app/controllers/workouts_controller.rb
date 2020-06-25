class WorkoutsController < ApplicationController
  include ApplicationHelper
  
    def index
      @trainer = Trainer.find_by(id: params[:trainer_id])
      if @trainer
        @workouts = @trainer.workouts # this will load only the trainer's workours
      else
        @workouts = Workout.all #loads all workouts
      end
    end

    def show
        @workout = Workout.find_by(id: params[:id])
    end
    
      def new
        @workout = Workout.new
        @workout.trainer = Trainer.find_by(id: params[:trainer_id])
      end

      def create
        workout = Workout.new(workout_params)
        workout.user = current_user
        workout.trainer = Trainer.find_by(id: params[:workout][:trainer_id])
        if workout.save
          flash[:notice] = "Workout created successfully."
          redirect_to workout_path(workout)
        else
          redirect_to new_trainer_workout_path(params[:workout][:trainer_id])
        end
      end

      def edit
        @workout = Workout.find_by(id: params[:id])
      end

      def update
        workout = Workout.find_by(id: params[:id])
        workout.update(workout_params)
        if workout.save
          flash[:notice] = "Workout updated successfully."
        redirect_to workout_path(workout)
        else
          flash[:alert] = "There was a problem updating the workout."
          render 'edit'
        end
      end

      def add_to_workouts
        workout = Workout.find_by(id: params[:workout_id])
        workout.user.id = current_user
        flash[:notice] = "Added to your workouts!"
        redirect_to user_path(current_user)
      end

      def destroy
        Workout.find(params[:id]).destroy
        redirect_to workouts_path
      end


      private

    def workout_params
      params.require(:workout).permit(
        :title,
        :description,
        :length,
        :difficulty,
        :user_id,
        :trainer_id
      )
    end
end
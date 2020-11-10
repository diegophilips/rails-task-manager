class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]
  def index
    @tasks = Task.all
  end

  def show
    display_completed
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.save
    redirect_to tasks_path(@tasks)
  end

  def update
    @task.update(task_params)
    redirect_to task_path(@task)
  end

  def edit; end

  def destroy
    @task.destroy
    redirect_to tasks_path
  end

  private

  def display_completed
    @completed = if @task.completed == true
                   'This tasks is completed'
                 else
                   'You still have to do this'
                 end
  end

  def task_params
    params.require(:task).permit(:title, :details, :completed)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end

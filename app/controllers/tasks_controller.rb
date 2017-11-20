# Controller for handling all task manipulation
class TasksController < ApplicationController

  # Find task in method first to prevent duplicate code
  before_action :find_task, only: [:show, :edit, :update, :destroy]

  # Only allow non users to view index and tasks, can not edit or delete
  before_action :authenticate_user!, except: [:index, :show]

  attr_accessor :task

  # GET /tasks
  # If params are set to :terms user is searching for tasks
  # True -> Get tasks that match searched terms
  # False -> Get all tasks
  def index
    @tasks = if params[:term]
    @task = Task.where('task LIKE ?', "%#{params[:term]}%")
    else
      @task = Task.all
    end
  end

  # GET /tasks/TASK ID
  def show

  end

  # GET /tasks/new
  # @task -> Gets new task for current user logged in
  def new
    @task = current_user.tasks.build
  end

  # GET /tasks/TASK ID/edit
  def edit

  end

  # POST /tasks
  # @task -> Creates new task in db from data collected from user
  # Checks if task was saved to db
  # True -> Successful db entry, returns to task and display msg OR shows data in json based on request
  # False -> db entry failed, show form with error msg OR shows data in json based on request
  # Return format based on client request
  def create
    @task = current_user.tasks.build(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'Task was successfully created!' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, notice: 'Task was not created, please try again.' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # Action updates existing task based task id
  # Checks if task was updated to db
  # True -> Successful db update, returns to task and display msg OR shows data in json based on request
  # False -> db update failed, show form with error msg OR shows data in json based on request
  # Return format based on client request
  def update

    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, notice: 'Task could not be updated, please try again.' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # Action deletes existing task based task id
  # Will also delete task comments and attachments
  # After deleting task redirect user to tasks index page with msg
  # Return json format based on client request
  def destroy
    @task.destroy

    respond_to do |format|
      format.html { redirect_to tasks_path, notice: 'The task was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  # Private can't be called outside intended context
  private

  # Gets current task from id in params
  def find_task
    @task = Task.find(params[:id])
  end

  # Task params collected from user when creating new task
  def task_params
    params.require(:task).permit(
        :task,
        :details,
        :due_date,
        { attachments: [] },
        :status,
        :remove_attachments,
        :term
    )
  end

end
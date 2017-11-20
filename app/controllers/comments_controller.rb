# Controller for handling all comment manipulation
class CommentsController < ApplicationController
  # POST /comments
  # @task -> Gets current task
  # @comment -> Gets user data for comment from params and saves to db
  # Checks if task was saved to db
  # Returns to task and display msg
  def create
    @task = Task.find(params[:task_id])
    @comment = @task.comments.create(comment_params)
    redirect_to task_path(@task), notice: 'Comment was successfully posted.'
  end

  # Action deletes an existing task's comment based task id
  # @task -> Gets current task
  # @comment -> Gets that task's comment from id passed in params
  # After deleting comment redirect user back to task with msg
  def destroy
    @task = Task.find(params[:task_id])
    @comment = @task.comments.find(params[:id])
    @comment.destroy
    redirect_to task_path(@task), notice: 'Comment was successfully deleted.'
  end

  private

  # Collects data passed in
  def comment_params
    params.require(:comment).permit(:name, :body)
  end

end
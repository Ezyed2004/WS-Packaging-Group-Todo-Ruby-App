# This controller controls the file processing of attachments on tasks.
# It is called when a user attempts to delete an attachment when viewing a task
class AttachmentsController < ApplicationController
  # Find attachment in method first to prevent duplicate code
  before_action :find_attachment, :set_task

  attr_accessor :task

  # NOTE: Is not currently being used
  # def create
    # add_more_attachments(attachments_params[:attachments])
    # flash[:notice] = 'Failed uploading images' unless @task.save
    # redirect_to :back
  # end

  # Action deletes file receive in params
  # First checks if file exists
  # True -> Delete File, removes file from attachments array, redirects back to task, and shows msg
  # False -> Redirects back to task and shows msg
  def destroy
    if File.exist?(@attachment_path)
      File.delete(@attachment_path)
      remove_attachment_at_index(@file_index)
      redirect_to task_path(@task.id), notice: @attachment_name + '  was successfully deleted.'
    else
      redirect_to task_path(@task.id), notice: @attachment_name + '  was not deleted.'
    end
  end

  # Private can't be called outside intended context
  private

  # Finds the index num of the file
  # Initial Loop -> Gets file's index num and file name from attachments array
  # Secondary Loop -> Tests current file name from array against file name of index num needed
  # True -> Matched attachments array file to file being processed, set file index
  # match_to_this -> Name of file need to match attachments array file to
  # index -> Index num of current attachments array file in initial loop
  # file_name -> File name of current attachments array file in initial loop
  # @file_index -> Index num of file being processed
  def find_index_of_file
    match_to_this = @attachment_name

    @task.attachments.each do |a|
      index = @task.attachments.index(a)
      file_name = a.url.split('/').last

      @task.attachments.each do |f|
        @file_index = index if file_name == match_to_this
      end
    end
  end

  # id -> file path
  # format -> file extension
  # @attachment -> File URL plus extension
  # @attachment_name -> Just file with extension
  # @attachment_path -> Complete file path from root
  def find_attachment
    @attachment = [params['id'], params['format']].compact.join '.'
    @attachment_name = @attachment.split('/').last
    @attachment_path = "#{Rails.root}/public" + @attachment
  end

  # NOTE: Is not currently being used
  # Updates attachments array after adding new file
  # attachments -> Copy attachments array, add new attachments to copied attachments array
  # @task.attachments -> Recreate updated attachments array
  # def add_more_attachments(new_attachments)
  #  attachments = @task.attachments
  #  attachments += new_attachments
  #  @task.attachments = attachments
  # end

  # Updates attachments array after deleting file
  # remain_attachments -> Copy attachments array
  # deleted_attachments -> Remove file from copied attachments array
  # @task.attachments -> Recreate updated attachments array
  def remove_attachment_at_index(index)
    remain_attachments = @task.attachments
    deleted_attachments = remain_attachments.delete(index)
    deleted_attachments.try(:remove!)
    @task.attachments = remain_attachments
  end

  # This NEEDS to be set AFTER find_attachment
  # task_id -> Finds task id from attachment's url
  # @task -> Uses the task_id in order to get the task associated with the attachment
  def set_task
    task_id = @attachment.split('/')[4]
    @task = Task.find(task_id)
  end

  def attachment_params
    params.require(:id).permit(:id, :format, attachment: [])
  end

end
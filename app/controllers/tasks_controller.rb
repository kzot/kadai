class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  # GET /tasks
  def index
    @toptask = Task.last
    @tasks = Task.rank(:row_order)

  end

  # GET /tasks/1
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to tasks_path, notice: 'タスクを作成しました' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /tasks/1
  def update
    respond_to do |format|
      if @task.update(task_params)
        if params[:task][:finished] == "true"
          format.html { redirect_to tasks_path, notice: 'タスクを完了しました' }
        else
          format.html { redirect_to tasks_path, notice: 'タスクを編集しました' }
        end
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /tasks/1
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'タスクを削除しました.' }
    end
  end

  def sort
    task = Task.find(params[:task_id])
    task.update(task_params)
    render nothing: true
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.fetch(:task, {}).permit(:title, :content, :priority, :finished,:row_order_position).merge(account_id:current_user.id)
    end

end

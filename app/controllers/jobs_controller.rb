class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update, :destroy]
  before_action :set_balance_for_current_user, only: [:create]
  before_action :set_balance_for_bid_user, only: [:create]

  def index
    @jobs = Job.all
  end

  def show
  end

  def new
    @job = Job.new
    @posts = Post.all
    @users = User.all
    @bids = Bid.all
  end

  def edit
  end

  def create
    @job = Job.new(job_params)
      if @job.save
        redirect_to @job, notice: 'Job was successfully created.'
      else
        render :new
      end
  end

  def update
      if @job.update(job_params)
        redirect_to @job, notice: 'Job was successfully updated.'
      else
        render :edit
      end
  end

  def destroy
    @job.destroy
      redirect_to jobs_url, notice: 'Job was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @job = Job.find(params[:id])
    end

    def set_balance_for_current_user
    
      @user = User.find(job_params[:user_id])
      
      @bid = Bid.find(job_params[:id])

      if @user.balance > @bid.bid
        $newvalue = (@user.balance - @bid.bid)
        @user.update_attribute(:balance, $newvalue)
        Post.find(params[:job][:post_id]).delete
            

      

      else
        @user = User.find(job_params[:bid_user_id])
        $bidvalue = (@user.balance - @bid.bid)
        @user.update_attribute(:balance, $bidvalue)

 
        redirect_to jobs_url, notice: "Not enough credits"
      end
    end
    
    def set_balance_for_bid_user
      @user = User.find(job_params[:bid_user_id])


      $bidvalue = (@user.balance + @bid.bid)
      @user.update_attribute(:balance, $bidvalue)

    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def job_params
      params.require(:job).permit(:title, :description, :id,:user_id, :bid_user_id, :post_id)
    end
end

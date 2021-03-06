class BidsController < ApplicationController
  before_action :set_bid, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  #before_action :check_balance, only: [:create]

  def index
    @bidss = Bid.all.order("created at DESC").paginate(:per_page => 22, :page => params[:page])
    @posts = Post.all
    @post = Post.find(params[:post_id])
    @bids = @post.bids
    @users = User.all
    @accounts = Account.all
  end

  def show
    @bids = Bid.all
    @posts = Post.all
    @post = Post.find(params[:post_id])
    @bids = @post.bids
    @users = User.all
  end

  def new
    @bid = Bid.new
    @posts = Post.all
    @post = Post.find(params[:post_id])
    @users = User.all
  end

  def edit
   @bid = Bid.new
    @posts = Post.all
    @post = Post.find(params[:post_id])
    @users = User.all


  end

  def create
    @bids = Bid.all
    @bid = Bid.new(bid_params)
    @users = User.all
    @user = User.find(bid_params[:user_id])
    @post = Post.find(bid_params[:post_id])


  if @bid.bid > 0

    if @bid.save

      BidMailer.new_bid_mail(@post).deliver

      redirect_to post_bids_path,  notice: 'Bid was successfully created.'

        else
          render :new
    end

    else
      render :new

    end
  end

  def update
      if @bid.update(bid_params)
        redirect_to @bid, notice: 'Bid was successfully updated.'
      else
        render :edit
      end
  end

  def destroy
    @bid.destroy
      redirect_to post_bids_url, notice: 'Bid was successfully destroyed.'
  end
#for admin dashboard
  def admin_bids
    @bids = Bid.all
    @posts = Post.all
    @users = User.all
    @accounts = Account.all

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bid
      @bid = Bid.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bid_params
      params.require(:bid).permit(:bid, :bidinfo, :post_id, :user_id)
    end

end

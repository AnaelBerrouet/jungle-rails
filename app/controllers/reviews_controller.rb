class ReviewsController < ApplicationController

  before_action :authorize, only: [:create, :destroy]

  def new
  end

  def create

    @product = Product.find(params[:product_id])

    # @review = product.reviews.new(review_params)
    @review = Review.new(review_params)
    @review.user = current_user
    @review.product = @product

    if @review.save
      flash[:notice] = "Review created successfully!"
      redirect_to product_path(@product)
    else
      flash[:notice] = "Review could not be created! - "
      # puts "#{@review.errors.messages}"
      redirect_to product_path(@product)
    end
  end

  def destroy
    @product = Product.find(params[:product_id])
    @review = @product.reviews.find(params[:id])
    @review.destroy
    redirect_to product_path(@product)
  end


  private

  def review_params
    params.require(:review).permit(
      :description,
      :rating
    )
  end

end

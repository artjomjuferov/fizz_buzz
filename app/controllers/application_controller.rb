class ApplicationController < ActionController::Base

  def home
    amount   = get_int_param(params[:amount]) || 100
    page     = get_int_param(params[:page])   || 1
    @numbers = get_numbers amount, page
    # don't know why respond_to does not work
    if request.headers['Content-Type'] == 'application/json'
      render json: { numbers: @numbers }
    end
  end

  def make_favorite
    number   = params[:number]
    favorite = Favorite.find_or_create_by number: number
    render json: {was_marked: favorite.valid?}, status: get_status(favorite)
  end

  private

  def get_int_param value
    # if it's wrong value we set default
    int_value = Integer(value) rescue nil
    # return only if it's positive
    int_value if int_value and  int_value > 0
  end

  def get_status favorite
    favorite.valid? ? :ok : :not_acceptable
  end

  def get_numbers amount, page
    numbers = (((page-1)*amount+1)..page*amount).to_a
    numbers.map{|number| Number.new(number).to_hash }
  end

end

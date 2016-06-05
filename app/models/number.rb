class Number
  def initialize value
    @value = value
  end

  def to_s
    @value
  end

  def to_hash
    {
        name:        name,
        number:      @value,
        is_favorite: is_favorite?
    }
  end

  private

  def is_favorite?
    Favorite.where(number: @value).exists?
  end

  def name
    if @value % 3 == 0 and @value % 5 == 0
      'FizzBuzz'
    elsif @value % 3 == 0
      'Fizz'
    elsif @value % 5 == 0
      'Buzz'
    end
  end
end
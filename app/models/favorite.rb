class Favorite < ActiveRecord::Base
  validates :number, presence:    true,
                      uniqueness: true,
                      numericality: {
                          greater_than_or_equal_to: 1,
                          less_than_or_equal_to:    10**11,
                          only_integer:             true
                      }
end

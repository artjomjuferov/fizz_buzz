module ApplicationHelper

  def favorite is_favorite, number
    is_favorite ? 'Favorite' : link(number)
  end

  private

  def link number
    link_to 'Make favorite', make_favorite_path(number), remote: true, method: :put
  end
end

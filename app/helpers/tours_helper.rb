module ToursHelper
  def load_tours_by_category id
    return Tour.imminent if id.nil?

    category = Category.find_by id: id
    Tour.same_kind id unless category.parent_id.nil?
  end

  def liked_review review
    review.likes.each do |like|
      return true if like.user_id == current_user.id
    end
    false
  end

  def current_user_like review
    review.likes.each{|like| return like if like.user_id == current_user.id}
  end
end

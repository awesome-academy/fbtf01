module ToursHelper
  def load_tours_by_category id
    return Tour.imminent if id.nil?

    category = Category.find_by id: id
    Tour.same_kind id unless category.parent_id.nil?
  end

  def load_tours_by_search params
    if params[:date_from].blank? || params[:date_to].blank?
      Tour.name_contains params[:search]
    else
      tours_by_duration = Tour.duration params[:date_from], params[:date_to]
      Tour.name_contains(params[:search]).merge tours_by_duration
    end
  end

  def search_tours_properly?
    !search_blank?(params[:search]) &&
      !from_after_to?(params[:date_from], params[:date_to])
  end

  def search_blank? search
    if search.blank?
      flash[:danger] = t "tours.flash.empty_search"
      return true
    end
    false
  end

  def from_after_to? from, to
    if !from.blank? && !to.blank?
      if from.to_time > to.to_time
        flash[:danger] = t "tours.flash.from_after_to"
        return true
      end
    end
    false
  end

  def handle_tours_search params
    if params[:search]
      if search_tours_properly?
        @tours = load_tours_by_search(params).paginate page: params[:page],
        per_page: Settings.tours.paginate.per_page
      else
        redirect_to root_path
      end
    else
      @tours = load_tours_by_category(params[:category_id]).paginate page:
        params[:page], per_page: Settings.tours.paginate.per_page
    end
  end
end

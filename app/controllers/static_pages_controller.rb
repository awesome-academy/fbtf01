class StaticPagesController < ApplicationController
  def home
    @q = Tour.ransack params[:tours]
    @tours = @q.result(distinct: true).includes(:locations).paginate page:
      params[:page], per_page: Settings.tours.paginate.per_page
  end
end

class Site::SearchController < SiteController
  def questions
    query = params[:term]
    @questions = Question.includes(:answers)
                         .where("lower(description) LIKE ?", "%#{params[:term].downcase}%")
                         .page(params[:page])
  end
end

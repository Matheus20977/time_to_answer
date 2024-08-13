class Site::AnswerController < SiteController
  def question
    id = params[:answer_id]
    @answer = Answer.find(id)
  end
end

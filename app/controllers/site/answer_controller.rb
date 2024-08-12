class Site::AnswerController < SiteController
  def question
    id = params[:answer_id]
    @answer = Answer.find(id)

    if @answer.correct
      flash[:success] = "Parabéns! Sua resposta está correta!"
    else
      flash[:danger] = "Que pena! Sua resposta está incorreta!"
    end

    redirect_to root_path
  end
end

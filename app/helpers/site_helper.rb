module SiteHelper
  def msg_jumbotron
    case params[:action]
      when 'index'
        "Últimas perguntas cadastradas..."
      when 'questions'
        "Resultados para o termo \"#{params[:term]}\"..."
      when 'subject'
        subject = Subject.find(params[:subject_id]).description
        "Resultados para o assunto \"#{subject}\"..."
    end
  end
end

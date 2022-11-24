module AnswersHelper
  def answer_header(answer)
    header = answer.new_record? ? 'Создать ' : 'Редактировать '
    header + "ответ на вопрос #{answer.question.body}"
  end
end

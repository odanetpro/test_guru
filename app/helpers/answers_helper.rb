# frozen_string_literal: true

module AnswersHelper
  def answer_header(answer)
    header = answer.new_record? ? 'Создать ' : 'Редактировать '
    header + "ответ на вопрос #{answer.question.body}"
  end

  def show_correct(correct)
    correct ? 'Да' : 'Нет'
  end
end

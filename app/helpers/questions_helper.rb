# frozen_string_literal: true

module QuestionsHelper
  def question_header(question)
    header = question.new_record? ? 'Создать ' : 'Редактировать '
    header + "вопрос для теста #{question.test.title}"
  end
end

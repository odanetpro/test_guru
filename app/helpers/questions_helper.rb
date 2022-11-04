module QuestionsHelper
  def question_header
    header = @question.new_record? ? 'Создать ' : 'Редактировать '
    header += "вопрос для теста #{@question.test.title}"
  end
end

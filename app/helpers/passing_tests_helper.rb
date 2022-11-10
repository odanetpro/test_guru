module PassingTestsHelper
  def percents_color(percents)
    percents < 85 ? 'red' : 'green'
  end

  def result_message(percents)
    percents < 85 ? 'Тест не пройден :(' : 'Тест пройден!'
  end
end

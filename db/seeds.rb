# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Category.create(title: 'Информатика')
User.create([{name: 'admin'}, {name: 'user'}])
 
#тест 'Ruby' категория 'Информатика'
test = Test.create(title: 'Ruby', category_id: Category.find_by(title: 'Информатика').id, author_id: User.find_by(name: 'admin').id)
  
question = Question.create(body: 'Где записана сокращенная форма кода ниже: x = x/3', test_id: test.id)
Answer.create(body: 'x /= 3', question_id: question.id, correct: true)
Answer.create(body: 'Нет сокращенной формы', question_id: question.id)
Answer.create(body: 'x = / 3', question_id: question.id)

question = Question.create(body: 'Чем отличается puts от print:', test_id: test.id)
Answer.create(body: 'Ничем, оба делают одно и тоже', question_id: question.id)
Answer.create(body: 'print без пропуска строки, а puts с пропуском', question_id: question.id, correct: true)
Answer.create(body: 'puts позволяет выводить переменные, а print только текст', question_id: question.id)

question = Question.create(body: 'Какой метод позволяет перевести строку в нижний регистр:', test_id: test.id)
Answer.create(body: 'lowercase()', question_id: question.id)
Answer.create(body: 'dcase()', question_id: question.id)
Answer.create(body: 'downcase()', question_id: question.id, correct: true)

question = Question.create(body: 'Создатель Ruby:', test_id: test.id)
Answer.create(body: 'Билл Гейтц', question_id: question.id)
Answer.create(body: 'Марк Цукербург', question_id: question.id)
Answer.create(body: 'Юкихиро Мацумото (Matz)', question_id: question.id, correct: true)

question = Question.create(body: 'Что выведет этот код: some = 25 print(«Переменная: » + some):', test_id: test.id)
Answer.create(body: 'Выведет: «Переменная: some»', question_id: question.id)
Answer.create(body: 'Выведет: «Переменная: 25»', question_id: question.id)
Answer.create(body: 'Будет выведена ошибка', question_id: question.id, correct: true)

question = Question.create(body: 'Где указана пустая переменная (без какого-либо значения):', test_id: test.id)
Answer.create(body: 'some = 0', question_id: question.id)
Answer.create(body: 'some = nil', question_id: question.id, correct: true)
Answer.create(body: 'some = «»', question_id: question.id)

question = Question.create(body: 'В каком варианте вы получите число без пропуска строки от пользователя:', test_id: test.id)
Answer.create(body: 'num = gets.to_i', question_id: question.id)
Answer.create(body: 'num = gets.chomp()', question_id: question.id)
Answer.create(body: 'num = gets.chomp().to_i', question_id: question.id, correct: true)

question = Question.create(body: 'Как называется самый популярный фреймворк Ruby для веба:', test_id: test.id)
Answer.create(body: 'Ruby On Rails', question_id: question.id, correct: true)
Answer.create(body: 'Ruby Web', question_id: question.id)
Answer.create(body: 'Ruby Framework', question_id: question.id)

question = Question.create(body: 'Что покажет этот код: num = -6 num *= 2 num = num.abs() res = Math.sqrt(num * 12) print(«Результат: » + res.round().to_s):', test_id: test.id)
Answer.create(body: 'Выведет: Ошибку', question_id: question.id)
Answer.create(body: 'Выведет: «Результат: -12»', question_id: question.id)
Answer.create(body: 'Выведет: «Результат: 12', question_id: question.id, correct: true)

question = Question.create(body: 'Сработает ли данный код: print(«Введите имя: ») name = gets puts(«Имя: » + name)', test_id: test.id)
Answer.create(body: 'Необходимо дописать gets.chomp()', question_id: question.id)
Answer.create(body: 'Код сработает в любом случае', question_id: question.id, correct: true)
Answer.create(body: 'Код сработает только если введут строку, а не число', question_id: question.id)

PassingTest.create(user_id: User.find_by(name: 'user').id, test_id: Test.find_by(title: 'Ruby').id)

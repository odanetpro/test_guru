document.addEventListener('turbolinks:load', function() {
  const progressBarLine = document.querySelector('.progress-bar-line')

  if (progressBarLine) {
    progressBarLineHandler(progressBarLine)
  }
})

function progressBarLineHandler(progressBarLine) {
  const currentQuestion = progressBarLine.dataset.currentQuestion
  const questionsTotal = progressBarLine.dataset.questionsTotal

  if (!currentQuestion || !questionsTotal) {
    return
  }

  const percentage = currentQuestion * 100.0 / questionsTotal
  progressBarLine.style.width = `${percentage}%`
}

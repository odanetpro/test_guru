document.addEventListener('turbolinks:load', function() {
  const passingTestForm = document.querySelector('#passing-test-form')
  const timeLeftElement = document.querySelector('#time-left')
  
  if (!passingTestForm || !timeLeftElement) {
    return
  }

  // prevent the creation of multiple timers
  if (window.tId) {
    clearInterval(window.tId)
  }

  window.timeLeft = Number(timeLeftElement.dataset.timeLeft)
  timeLeftElement.innerHTML = secondsToHms(window.timeLeft + 1)
    
  window.tId = setInterval(timer, 1000, passingTestForm, timeLeftElement)
})

function timer(passingTestForm, timeLeftElement) {
  if (window.timeLeft <= 0) {
    passingTestForm.submit()
  }
  
  timeLeftElement.innerHTML = secondsToHms(window.timeLeft)
  window.timeLeft -= 1
}

function secondsToHms(seconds) {
  var h = Math.floor(seconds / 3600)
  var m = Math.floor(seconds % 3600 / 60)
  var s = Math.floor(seconds % 3600 % 60)

  var hh = h > 0 ? (h < 10 ? "0" : "") + h + ":" : "";
  var mm = m >= 0 ? (m < 10 ? "0" : "") + m + ":" : "";
  var ss = s >= 0 ? (s < 10 ? "0" : "") + s : "";

  return hh + mm + ss
}

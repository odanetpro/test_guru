document.addEventListener('turbolinks:load', function() {
    const pwd = document.querySelector('#user_password')
    const pwd_confirm = document.querySelector('#user_password_confirmation')

    if (pwd && pwd_confirm) {
        pwd.addEventListener('input', passwordMatch)
        pwd_confirm.addEventListener('input', passwordMatch)
      }
  })

function passwordMatch() {
  const pwd = document.querySelector('#user_password')
  const pwd_confirm = document.querySelector('#user_password_confirmation')

  if(!pwd_confirm.value) {
    document.querySelector('.bi-check-lg').classList.add('hide')
    document.querySelector('.bi-x-lg').classList.add('hide')
  } else if (pwd.value === pwd_confirm.value) {
    document.querySelector('.bi-check-lg').classList.remove('hide')
    document.querySelector('.bi-x-lg').classList.add('hide')
  } else {
    document.querySelector('.bi-check-lg').classList.add('hide')
    document.querySelector('.bi-x-lg').classList.remove('hide')
  }
}

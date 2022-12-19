document.addEventListener('turbolinks:load', function() {
  const controls = document.querySelectorAll('.form-inline-link')

  if (controls.length) {
    for (let i = 0; i < controls.length; i++) {
      controls[i].addEventListener('click', formInlineLinkHandler)
    }
  }

  const errors = document.querySelector('.resource-errors')

  if (errors) {
    const resourceId = errors.dataset.resourceId
    formInlineHandler(resourceId)
  }
})

function formInlineLinkHandler(event) {
  event.preventDefault()

  const testId = this.dataset.testId
  formInlineHandler(testId)
}

function formInlineHandler(testId) {
  let link = document.querySelector(`.form-inline-link[data-test-id="${testId}"]`)
  let testTitle = document.querySelector(`.test-title[data-test-id="${testId}"]`)
  let formInline = document.querySelector(`.form-inline[data-test-id="${testId}"]`)

  if (formInline.classList.contains('hide')) {
    testTitle.classList.add('hide')
    formInline.classList.remove('hide')
    formInline.classList.add('flex')
    link.textContent = I18n.admin.tests.test.link_cancel
  } else {
    testTitle.classList.remove('hide')
    formInline.classList.add('hide')
    formInline.classList.remove('flex')
    link.textContent = I18n.admin.tests.test.link_edit
  }
}

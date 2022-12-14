document.addEventListener('turbolinks:load', function() {
  const control = document.querySelector('.sort-by-title')

  if (control) {
    control.addEventListener('click', sortRowsByTitle)
  }
})

function sortRowsByTitle() {
  const table = document.querySelector('table')
  const rows = table.querySelectorAll('tr')
  
  let sortedRows = []
  for (let i = 1; i < rows.length; i++) {
    sortedRows.push(rows[i])
  }
  
  if(this.querySelector('.bi-sort-alpha-down').classList.contains('hide')) {
    sortedRows.sort(compareRowsAsc)
    this.querySelector('.bi-sort-alpha-up-alt').classList.add('hide')
    this.querySelector('.bi-sort-alpha-down').classList.remove('hide')
  } else {
    sortedRows.sort(compareRowsDesc)
    this.querySelector('.bi-sort-alpha-down').classList.add('hide')
    this.querySelector('.bi-sort-alpha-up-alt').classList.remove('hide')
  }

   let sortedTable = document.createElement('table')
   sortedTable.classList.add('table')
   sortedTable.classList.add('table-striped')

   const fragment = document.createElement('tbody')
   fragment.appendChild(rows[0])
   sortedRows.forEach(item => fragment.appendChild(item))
   sortedTable.appendChild(fragment)

   table.parentNode.replaceChild(sortedTable, table)
}

function compareRowsAsc(row1, row2) {
  const testTitle1 = row1.querySelector('td').textContent
  const testTitle2 = row2.querySelector('td').textContent

  if (testTitle1 < testTitle2) { return -1 }
  if (testTitle1 > testTitle2) { return 1 }
  return 0
}

function compareRowsDesc(row1, row2) {
    const testTitle1 = row1.querySelector('td').textContent
    const testTitle2 = row2.querySelector('td').textContent
  
    if (testTitle1 < testTitle2) { return 1 }
    if (testTitle1 > testTitle2) { return -1 }
    return 0
  }

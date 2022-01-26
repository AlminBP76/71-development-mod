'use strict'

const DATE_FORMAT = '****/**/**'
const DATE_PLACEHOLDER = 'YYYY/MM/DD'



const passport = document.querySelector('.passport')
passport.addEventListener('click', () => {
  passport.classList.add('passport--open')
})

const randomPassportNumber = (Math.floor(Math.random() * 99999999 + 1)).toString().padStart(8, '0')
document.querySelector('#passport-number').innerText = randomPassportNumber

const birthdate = document.querySelector('#birthdate')
function DoFormat(x, pattern, mask) {
  var strippedValue = x.replace(/[^0-9]/g, '')
  var chars = strippedValue.split('')
  var count = 0

  var formatted = ''
  for (let i = 0; i < pattern.length; i++) {
    const c = pattern[i]
    if (chars[count]) {
      if (/\*/.test(c)) {
        formatted += chars[count]
        count++
      } else {
        formatted += c
      }
    } else if (mask) {
      if (mask.split('')[i])
        formatted += mask.split('')[i]
    }
  }
  return formatted;
}

function Format() {
  const val = DoFormat(birthdate.value, DATE_FORMAT)
  birthdate.value = DoFormat(birthdate.value, DATE_FORMAT, DATE_PLACEHOLDER)

  if (birthdate.createTextRange) {
    var range = birthdate.createTextRange()
    range.move('character', val.length)
    range.select()
  } else if (birthdate.selectionStart) {
    birthdate.focus()
    birthdate.setSelectionRange(val.length, val.length)
  }
}

Format()

birthdate.addEventListener('input', Format)

const sex = document.querySelector('#sex')
const picture = document.querySelector('.passport__picture')
sex.addEventListener('change', function() {
  if (sex.value == 'm') {
    picture.classList.remove('passport__picture--female')
    picture.classList.add('passport__picture--male')
  } else {
    picture.classList.remove('passport__picture--male')
    picture.classList.add('passport__picture--female')
  }
})

const height = document.querySelector('#height')
height.addEventListener('input', () => {
  height.value = height.value.replace(/[^\d]/, '')
})

const nameInput = document.querySelector('#name')
const surnameInput = document.querySelector('#surname')
function UpdateSignature() {
  let surname = surnameInput.value.charAt(0).toUpperCase() + surnameInput.value.slice(1)
  let signature = (nameInput.value.length > 0 ? nameInput.value[0].toUpperCase() + '. ' : '') + (surname.length > 0 ? surname : '')
  document.querySelector('.passport__field--signature').innerText = signature
}
nameInput.addEventListener('input', UpdateSignature)
surnameInput.addEventListener('input', UpdateSignature)
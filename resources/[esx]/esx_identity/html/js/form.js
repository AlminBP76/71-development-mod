const MAX_NAME_LENGTH = 20
const LOWEST_YEAR = 1900
const HIGHEST_YEAR = 2010
const MIN_HEIGHT = 140
const MAX_HEIGHT = 200

class FormValidator {
  constructor(form, fields) {
    this.form = form
    this.fields = fields
  }

  Initialize() {
    let self = this

    this.form.addEventListener('submit', event => {
      event.preventDefault()

      let allFieldsValid = true
      self.fields.forEach(field => {
        const fieldElement = document.querySelector(`#${field}`)
        if (!self.ValidateField(fieldElement)) {
          allFieldsValid = false
        }
      })

      if (allFieldsValid) {
        let data = {
          firstname: document.querySelector('#name').value.trim(),
          lastname: document.querySelector('#surname').value.trim(),
          dateofbirth: document.querySelector('#birthdate').value,
          sex: document.querySelector('#sex').value,
          height: document.querySelector('#height').value.trim()
        }

        fetch('http://esx_identity/register', {
          method: 'POST',
          body: JSON.stringify(data)
        })
      }
    })
  }

  ValidateField(field) {
    if (field.value.trim() === '') {
      this.Error(field)
      return false
    }

    if (field.id === 'surname' || field.id === 'name') {
      const regularExpression = /^[a-zA-Z]+$/
      if (!regularExpression.test(field.value.trim())) {
        this.Error(field)
        return false
      }
    }

    if (field.id === 'birthdate') {
      if (/^\d\d\d\d\/\d\d\/\d\d$/.test(field.value)) {
        let [yyyy, mm, dd] = field.value.split('/').map(p => parseInt(p, 10))
        mm -= 1
        const date = new Date(yyyy, mm, dd)
        if (date.getMonth() === mm && date.getDate() === dd && date.getFullYear() === yyyy) {
          if (date.getFullYear() >= LOWEST_YEAR && date.getFullYear() <= HIGHEST_YEAR) {
            return true
          }
        }
      }

      this.Error(field)
      return false
    }

    if (field.id === 'height') {
      let height = parseInt(field.value)
      if (height < MIN_HEIGHT || height > MAX_HEIGHT) {
        this.Error(field)
        return false
      }
    }

    return true
  }

  Error(field) {
    field.classList.remove('passport__field--error')
    setTimeout(() => {
      field.classList.add('passport__field--error')
    }, 100)
  }
}

const form = document.querySelector('#form')
const fields = ['surname', 'name', 'birthdate', 'sex', 'height']

const validator = new FormValidator(form, fields)
validator.Initialize()
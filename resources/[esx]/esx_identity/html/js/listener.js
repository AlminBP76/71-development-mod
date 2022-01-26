window.addEventListener('message', event => {
  if (event.data.type == 'enableui') {
    if (event.data.enable) {
      document.documentElement.style.display = 'block'
    } else {
      document.documentElement.style.display = 'none'
      document.querySelector('form').reset()
      document.querySelector('.passport__field--signature').innerText = ''
      document.querySelector('.passport').classList.remove('passport--open')
    }
  }
})
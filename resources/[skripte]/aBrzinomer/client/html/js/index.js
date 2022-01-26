var opac = anime({
    targets: '.letter',
    opacity:1,
    scale:1,
      easing:'easeInBounce',
      delay: function(el, index) {
        return index * 80;
      },
    direction: 'alternate',
    loop: true
});

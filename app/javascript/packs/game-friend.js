document.addEventListener('DOMContentLoaded', () => {
  const about = document.querySelector('.controller');
  if (about) {
    const keyframes = {opacity: [0, 1]};
    about.animate(keyframes, 2000);
  } else {
    console.error('Element with class "controller" not found');
  }
});

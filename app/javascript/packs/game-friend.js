document.addEventListener('turbolinks:load', () => {
  const about = document.querySelector('.controller');
  if (about) {
    const keyframes = {opacity: [0, 1]};
    about.animate(keyframes, 2000);
  } else {
    console.error('Element with class "controller" not found');
  }
});


const animateFade = (entries, obs) => {
  entries.forEach((entry) => {
    if (entry.isIntersecting) {
      entry.target.animate(
        {
          opacity: [0, 1],
          filter: ['blur(.4rem)', 'blur(0)'],
          transform: ['translateY(4rem)', 'translateY(0)'],
        },
        {
          duration: 2000,
          easing: 'ease',
          fill: 'forwards',
        }
      );
      obs.unobserve(entry.target);
    }
  });
};
document.addEventListener('DOMContentLoaded', () => {
  const options = {
  root: null, // ビューポートを基準にする（デフォルト）
  rootMargin: '0px', // ビューポートからのマージン
  threshold: 0.8 // 要素の50%が見えたらコールバックを呼び出す
  };

  const fadeObserver = new IntersectionObserver(animateFade, options);

  const fadeElements = document.querySelectorAll('.fadein');
  fadeElements.forEach((fadeElement) => {
    fadeObserver.observe(fadeElement);
  });
});

fadeElements.forEach((fadeElement) => {
  fadeObserver.observe(fadeElement);
});
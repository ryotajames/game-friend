document.addEventListener('turbolinks:load', () => {
  const about = document.querySelector('.controller');
  if (about) {
    const keyframes = {opacity: [0, 1]};
    about.animate(keyframes, 2000);
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

document.addEventListener('turbolinks:load', () => { // Turbolinksイベントを使用
  const options = {
    root: null, // ビューポートを基準にする（デフォルト）
    rootMargin: '0px', // ビューポートからのマージン
    threshold: 0.8 // 要素の80%が見えたらコールバックを呼び出す
  };

  const fadeObserver = new IntersectionObserver(animateFade, options);
  const fadeElements = document.querySelectorAll('.fadein');
  fadeElements.forEach((fadeElement) => {
    fadeObserver.observe(fadeElement);
  });
});



var ctx;
var width = window.innerWidth * 0.7;
var height = window.innerHeight * 0.7;
var t = 0;

const x11 = (t) => Math.sin(t / 10) * 200 + Math.sin(t / 5) * 40;
const y11 = (t) => Math.cos(-t / 10) * 200 + Math.sin(t / 5) * 100;
const x21 = (t) => Math.sin(t / 10) * 100 + Math.sin(t) * 2;  // 終点の振幅を縮小
const y21 = (t) => -Math.cos(t / 10) * 100 + Math.cos(t / 12) * 20;  // 終点の振幅を縮小
const NUM_LINES = 20;

document.addEventListener("turbolinks:load", function() {
    var c = document.getElementById('c');
    if (c) {
        ctx = c.getContext('2d');
        c.width = width;
        c.height = height;

        setup();
        loop();
    } else {
        console.error("Canvas element with id 'c' not found");
    }
});

function setup() {
    ctx.shadowBlur = 15;
    ctx.shadowColor = 'blue';
    ctx.strokeStyle = '#fff';
    ctx.lineWidth = 1.5;
}

function point(x, y, ctx) {
    ctx.beginPath();
    ctx.arc(x, y, 1, 0, 2 * Math.PI, true);
    ctx.stroke();
}

function line(x1, y1, x2, y2, ctx) {
    ctx.beginPath();
    ctx.moveTo(x1, y1);
    ctx.lineTo(x2, y2);
    ctx.closePath();
    ctx.stroke();
}

function loop() {
    window.requestAnimationFrame(loop);

    ctx.fillStyle = 'rgba(0,0,0, 0.8)';
    ctx.fillRect(0, 0, width, height);

    ctx.translate(width / 2, height / 2);

    for (let i = 0; i < NUM_LINES; i++) {
        line(x11(t + i), y11(t + i), x21(t + i), y21(t + i), ctx);
    }

    ctx.translate(-width / 2, -height / 2);

    t += 0.05;
}



